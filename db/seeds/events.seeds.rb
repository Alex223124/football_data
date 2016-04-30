require "csv"
require "sequel"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :games, :players, :possessions do
  puts "Updating Event data"

  lookups = {}

  puts "- Loading Field Goal and Extra Point data"
  fgxp = {}
  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/FGXP.csv", headers: true) do |row|
    fgxp[row["PID"]] = row["FGXP"]
  end
  lookups[:fgxp] = fgxp

  puts "- Loading First Down data"
  fdowns = {}
  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/FDOWNS.csv", headers: true) do |row|
    fdowns[row["PID"]] = true
  end
  lookups[:fdowns] = fdowns

  puts "- Loading No Huddle data"
  nohuddle = {}
  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/NOHUDDLE.csv", headers: true) do |row|
    nohuddle[row["PID"]] = true
  end
  lookups[:nohuddle] = nohuddle

  puts "- Loading Scoring data"
  scoring = {}
  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/SCORING.csv", headers: true) do |row|
    scoring[row["PID"]] = row["PTS"]
  end
  lookups[:scoring] = scoring

  puts "- Loading Shotgun data"
  shotgun = {}
  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/SHOTGUN.csv", headers: true) do |row|
    shotgun[row["PID"]] = true
  end
  lookups[:shotgun] = shotgun

  puts "- Loading Success data"
  splays = {}
  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/SPLAYS.csv", headers: true) do |row|
    splays[row["PID"]] = true
  end
  lookups[:splays] = splays

  puts "- Loading Spike data"
  spikes = {}
  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/SPIKES.csv", headers: true) do |row|
    spikes[row["PID"]] = true
  end
  lookups[:spikes] = spikes

  # knees
  puts "- Loading Knee data"
  knees = {}
  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/KNEES.csv", headers: true) do |row|
    knees[row["PID"]] = true
  end
  lookups[:knees] = knees

  puts "- Loading Pass data"
  pass = {}
  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/PASS.csv", headers: true) do |row|
    pass[row["PID"]] = row.to_hash.except("PID")
  end
  lookups[:pass] = pass

  puts "- Loading Completion data"
  comps = {}
  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/COMPS.csv", headers: true) do |row|
    comps[row["PID"]] = true
  end
  lookups[:comps] = comps

  puts "- Loading Interception data"
  ints = {}
  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/INTS.csv", headers: true) do |row|
    ints[row["PID"]] = true
  end
  lookups[:ints] = ints

  # mappings
  puts "- Loading Dimension data"
  mappings = db[:etl_mappings].where(source_type: ["pid", "player"]).all
  mappings.each do |mapping|
    lookups["#{mapping[:target_type]}#{mapping[:source_id]}"] = mapping[:target_id]
  end

  puts "- Processing Events"
  # events = []
  game = nil

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/CORE.csv", headers: true) do |row|
    if game != row["GID"]
      puts "  - Processing game #{row["GID"]}"
      game = row["GID"]
    end

    # Set the right play type
    play_type = parse_play_type(row["TYPE"])

    if play_type == "PointsKick"
      play_type = begin
        case lookups[:fgxp][row["PID"]]
        when "FG" then "FieldGoal"
        when "XP" then "ExtraPoint"
        end
      end
    end

    data = {}
    primary_player_id = nil
    secondary_player_id = nil

    # passes
    case play_type
    when "Pass"
      if hash = lookups[:pass][row["PID"]]
        data[:pass_attempt] = 1
        data[:pass_completion] = lookups[:comps][row["PID"]].present? ? 1 : 0
        data[:pass_yards] = hash["YDS"].to_i
        data[:pass_touchdown] = [6, 7, 8].include?(lookups[:scoring][row["PID"]].to_i) ? 1 : 0
        data[:pass_interception] = lookups[:ints][row["PID"]].present? ? 1 : 0
        primary_player_id = lookups["player#{hash["PSR"]}"]
        secondary_player_id = lookups["player#{hash["TRG"]}"]
      end
    end

    Event.create!(
      type:                play_type,
      first_down:          lookups[:fdowns][row["PID"]].present?,
      no_huddle:           lookups[:nohuddle][row["PID"]].present?,
      scoring:             lookups[:scoring][row["PID"]].present?,
      shotgun:             lookups[:shotgun][row["PID"]].present?,
      success:             lookups[:splays][row["PID"]].present?,
      spike:               lookups[:spikes][row["PID"]].present?,
      knee:                lookups[:knees][row["PID"]].present?,
      stadium_id:          lookups["stadium#{row["PID"]}"],
      game_id:             lookups["game#{row["PID"]}"],
      home_team_id:        lookups["home_team#{row["PID"]}"],
      visitor_team_id:     lookups["visitor_team#{row["PID"]}"],
      possession_id:       lookups["possession#{row["PID"]}"],
      offense_team_id:     lookups["offense_team#{row["PID"]}"],
      defense_team_id:     lookups["defense_team#{row["PID"]}"],
      primary_player_id:   primary_player_id,
      secondary_player_id: secondary_player_id,
      data:                data.empty? ? nil : data
    )
  end
end
