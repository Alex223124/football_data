require "csv"
require "sequel"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :games, :players do
  puts "Updating Possession data"

  db[:etl_mappings].where(source_type: "pid", target_type: ["game", "home_team", "visitor_team", "stadium", "offense_team", "defense_team", "possession"]).delete

  lookups = {}

  puts "- Loading Dimension data"
  mappings = db[:etl_mappings].where(source_type: ["gid", "team"]).all
  mappings.each do |mapping|
    lookups["#{mapping[:target_type]}#{mapping[:source_id]}"] = mapping[:target_id]
  end

  mappings = []
  game = nil

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/CORE.csv", headers: true) do |row|
    mappings << ["pid", row["PID"], "game", lookups["game#{row["GID"]}"]]
    mappings << ["pid", row["PID"], "home_team", lookups["home_team#{row["GID"]}"]]
    mappings << ["pid", row["PID"], "visitor_team", lookups["visitor_team#{row["GID"]}"]]
    mappings << ["pid", row["PID"], "stadium", lookups["stadium#{row["GID"]}"]]
    mappings << ["pid", row["PID"], "offense_team", lookups["team#{row["OFF"]}"]]
    mappings << ["pid", row["PID"], "defense_team", lookups["team#{row["DEF"]}"]]

    if game != row["GID"]
      puts "- Processing game #{row["GID"]}"
      game = row["GID"]
    end

    possession_id = db[:etl_mappings].where(source_type: "pid", source_id: row["PID"], target_type: "possession").first || {}
    possession_id = possession_id.fetch(:possession_id, nil)
    possession = Possession.find(possession_id) if possession_id
    possession ||= Possession.new(aa: row["PID"])

    possession.update_attributes!({
      length:           row["LEN"],
      quarter:          row["QTR"],
      minutes:          row["MIN"],
      seconds:          row["SEC"],
      offense_points:   row["PTSO"],
      defense_points:   row["PTSD"],
      offense_timeouts: row["TIMO"],
      defense_timeouts: row["TIMD"],
      down:             row["DWN"],
      yards_to_go:      row["YTG"],
      yards_from_goal:  row["YFOG"].to_i == 0 ? nil : row["YFOG"],
      zone:             cleanse_attribute(row["ZONE"], type: :int),
      drive_sequence:   row["DSEQ"]
    })

    # Update mapping table for possession
    mappings << ["pid", row["PID"], "possession", possession.id]
  end

  puts "- Updating Dimension mappings"
  db[:etl_mappings].import([:source_type, :source_id, :target_type, :target_id], mappings)
end
