require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :players, :possessions do
  puts "Updating Conversions data..."

  type = "conversion"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/CONVS.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    upsert_player_play_attribute(possession, row["BC"], type, "rushing_personnel", { source: "CONVS", pid: row["PID"], attribute: "BC" })
    upsert_player_play_attribute(possession, row["PSR"], type, "passing_personnel", { source: "CONVS", pid: row["PID"], attribute: "PSR" })
    upsert_player_play_attribute(possession, row["TRG"], type, "targeted_personnel", { source: "CONVS", pid: row["PID"], attribute: "TRG" })

    upsert_play_attribute(possession, row["TYPE"], type, "conversion_type")
    upsert_play_attribute(possession, row["CONV"], type, "conversion_success")
  end
end
