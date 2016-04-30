require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :stadiums, :teams do
  puts "Updating Game data"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/GAMES.csv", headers: true) do |row|
    stadium = parse_stadium(row["STAD"])
    super_bowl = row["DAY"] == "SB"
    time_of_day = ["TN", "SN", "MN"].include?(row["DAY"]) ? Game.time_of_days[:night] : Game.time_of_days[:early]

    game = Game.where("foreign_keys -> 'aa' = '#{row["GID"]}'").first
    game ||= Game.new(aa: row["GID"])
    game.update_attributes!({
      season: row["SEAS"],
      week: row["WEEK"],
      day: parse_day(row["DAY"]),
      temperature: cleanse_attribute(row["TEMP"], type: :int),
      humidity: row["HUMD"],
      wind_speed: cleanse_attribute(row["WSPD"], type: :int),
      wind_direction: cleanse_attribute(row["WDIR"], upcase: true),
      conditions: cleanse_attribute(row["COND"].downcase.titlecase),
      visitor_points: row["PTSV"],
      home_points: row["PTSH"],
      time_of_day: time_of_day,
      super_bowl: super_bowl
    })

    # Update mapping table for game
    if db[:etl_mappings].where(source_type: "gid", source_id: row["GID"], target_type: "game", target_id: game.id).count == 0
      db[:etl_mappings].insert(source_type: "gid", source_id: row["GID"], target_type: "game", target_id: game.id)
    end

    # Update mapping table for home team
    home_team = Team.find_by(abbreviation: row["H"])
    if db[:etl_mappings].where(source_type: "gid", source_id: row["GID"], target_type: "home_team", target_id: home_team.id).count == 0
      db[:etl_mappings].insert(source_type: "gid", source_id: row["GID"], target_type: "home_team", target_id: home_team.id)
    end

    # Update mapping table for visitor team
    visitor_team = Team.find_by(abbreviation: row["V"])
    if db[:etl_mappings].where(source_type: "gid", source_id: row["GID"], target_type: "visitor_team", target_id: visitor_team.id).count == 0
      db[:etl_mappings].insert(source_type: "gid", source_id: row["GID"], target_type: "visitor_team", target_id: visitor_team.id)
    end

    # Update mapping table for stadium
    stadium = Stadium.where("lower(name) LIKE ?", "%#{stadium}%").first
    if db[:etl_mappings].where(source_type: "gid", source_id: row["GID"], target_type: "stadium", target_id: stadium.id).count == 0
      db[:etl_mappings].insert(source_type: "gid", source_id: row["GID"], target_type: "stadium", target_id: stadium.id)
    end
  end
end
