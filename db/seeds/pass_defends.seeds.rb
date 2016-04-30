require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :players, :possessions do
  puts "Updating Pass Defenders data..."

  type = "pass_defend"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/DBACKS.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    upsert_player_play_attribute(possession, row["DFB"], type, "pass_defending_personnel", { source: "DBACKS", pid: row["PID"], attribute: "DFB" })
  end
end
