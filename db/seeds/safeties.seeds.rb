require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :players, :possessions do
  puts "Updating Safeties data..."

  type = "safety"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/SAFETIES.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    upsert_player_play_attribute(possession, row["SAF"], type, "forcing_personnel", { source: "SAFETIES", pid: row["PID"], attribute: "SAF" })
  end
end
