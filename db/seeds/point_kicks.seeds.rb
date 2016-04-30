require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :possessions do
  puts "Updating Points Kicks data..."

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/FGXP.csv", headers: true) do |row|
    type = row["FGXP"] == "FG" ? "field_goal" : "extra_point"

    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    upsert_player_play_attribute(possession, row["FKICKER"], type, "kicking_personnel", { source: "FGXP", pid: row["PID"], attribute: "FKICKER" })

    upsert_play_attribute(possession, row["DIST"], type, "kick_distance")
    upsert_play_attribute(possession, row["GOOD"], type, "kick_good")

    # Update our Play from points_kick to the actual kick type
    p.update_attributes!(play_type: type)
  end
end
