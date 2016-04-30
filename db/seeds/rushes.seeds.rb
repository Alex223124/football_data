require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

FIELD_LOCATIONS = {
  dl: "deep_left",
  dm: "deep_middle",
  dr: "deep_right",
  le: "left_end",
  lg: "left_guard",
  lt: "left_tackle",
  md: "middle",
  re: "right_end",
  rg: "right_guard",
  rt: "right_tackle",
  sl: "short_left",
  sm: "short_middle",
  sr: "short_right"
}.with_indifferent_access

after :setup, :players, :possessions do
  puts "Updating Rushes data..."

  type = "rush"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/RUSH.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    upsert_player_play_attribute(possession, row["BC"], type, "rushing_personnel", { source: "RUSH", pid: row["PID"], attribute: "BC" })
    upsert_play_attribute(possession, row["YDS"], type, "rush_yards")

    # Update our Play field location
    p.update_attributes!(field_location: FIELD_LOCATIONS[row["DIR"].downcase]) unless row["DIR"] == "NL"
  end
end
