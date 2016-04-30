require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

# after :setup, :players, :possessions do
  puts "Updating Tackles data..."

  type = "tackle"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/TACKLES.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    upsert_player_play_attribute(possession, row["TCK"], type, "forcing_personnel", { source: "TACKLES", pid: row["PID"], attribute: "TCK" })
    upsert_play_attribute(possession, row["VALUE"], type, "tackle_value")
  end
# end
