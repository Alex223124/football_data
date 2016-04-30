require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :players, :possessions do
  puts "Updating Interceptions data..."

  type = "interception"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/INTS.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    upsert_player_play_attribute(possession, row["INT"], type, "intercepting_personnel", { source: "INTS", pid: row["PID"], attribute: "INT" })

    upsert_play_attribute(possession, row["YDS"], type, "return_yards")
  end
end
