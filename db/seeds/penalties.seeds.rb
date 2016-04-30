require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

PENALTY_CATEGORIES = [
  "false_start",
  "offensive_holding",
  "execution",
  "defensive_line",
  "defensive_secondary",
  "dumb",
  "poor_fundamentals",
  "other"
]

PENALTY_ACTIONS = {
  d: "declined",
  o: "offsetting",
  a: "accepted"
}.with_indifferent_access

after :setup, :players, :possessions do
  puts "Updating Penalties data..."

  type = "penalty"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/PENALTIES.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)
    team = Team.find_by(abbreviation: row["PTM"])

    upsert_player_play_attribute(possession, row["PEN"], type, "penalized_personnel", { source: "PENALTIES", pid: row["PID"], attribute: "PEN" })

    upsert_play_attribute(possession, team, type, "penalized_team")
    upsert_play_attribute(possession, row["DESC"], type, "penalty_description")
    upsert_play_attribute(possession, PENALTY_CATEGORIES.fetch(row["CAT"].to_i - 1, nil), type, "penalty_category")
    upsert_play_attribute(possession, row["PEY"], type, "penalty_yards")
    upsert_play_attribute(possession, PENALTY_ACTIONS[row["ACT"].downcase], type, "penalty_action")
  end
end
