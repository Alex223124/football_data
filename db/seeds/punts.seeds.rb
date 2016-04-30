require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :players, :possessions do
  puts "Updating Punts data..."

  type = "punt"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/PUNTS.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    upsert_player_play_attribute(possession, row["PUNTER"], type, "kicking_personnel", { source: "PUNTS", pid: row["PID"], attribute: "PUNTER" })
    upsert_player_play_attribute(possession, row["PR"], type, "returning_personnel", { source: "PUNTS", pid: row["PID"], attribute: "PR" })

    upsert_play_attribute(possession, row["PGRO"], type, "gross_distance")
    upsert_play_attribute(possession, row["PNET"], type, "net_distance")
    upsert_play_attribute(possession, row["PTB"], type, "touchback")
    upsert_play_attribute(possession, row["PRY"], type, "return_yards")
    upsert_play_attribute(possession, row["PFC"], type, "fair_catch")
  end
end
