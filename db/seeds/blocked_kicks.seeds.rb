require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :players, :possessions do
  puts "Updating Blocked Kicks data..."

  type = "blocked_kick"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/BLOCKS.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    upsert_player_play_attribute(possession, row["BLK"], type, "blocking_personnel", { source: "BLOCKS", pid: row["PID"], attribute: "BLK" })
    upsert_player_play_attribute(possession, row["BRCV"], type, "recovering_personnel", { source: "BLOCKS", pid: row["PID"], attribute: "BRCV" })
  end
end
