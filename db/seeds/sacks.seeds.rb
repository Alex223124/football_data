require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :players, :possessions do
  puts "Updating Sacks data..."

  type = "sack"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/SACKS.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    upsert_player_play_attribute(possession, row["QB"], type, "quarterback", { source: "SACKS", pid: row["PID"], attribute: "QB" })
    upsert_player_play_attribute(possession, row["SK"], type, "sacking_personnel", { source: "SACKS", pid: row["PID"], attribute: "SK" })

    upsert_play_attribute(possession, row["VALUE"], type, "sack_value")
    upsert_play_attribute(possession, row["YDSL"], type, "yards_lost")
  end
end
