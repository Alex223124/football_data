require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :players, :possessions do
  puts "Updating Fumbles data..."

  type = "fumble"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/FUMBLES.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    upsert_player_play_attribute(possession, row["FUM"], type, "fumbling_personnel", { source: "FUMBLES", pid: row["PID"], attribute: "FUM" })
    upsert_player_play_attribute(possession, row["FRCV"], type, "recovering_personnel", { source: "FUMBLES", pid: row["PID"], attribute: "FRCV" })
    upsert_player_play_attribute(possession, row["FORC"], type, "forcing_personnel", { source: "FUMBLES", pid: row["PID"], attribute: "FORC" })

    upsert_play_attribute(possession, row["FRY"], type, "return_yards")
  end
end
