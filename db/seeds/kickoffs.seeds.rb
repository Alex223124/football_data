require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :players, :possessions do
  puts "Updating Kickoffs data..."

  type = "kickoff"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/KICKOFFS.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    upsert_player_play_attribute(possession, row["KICKER"], type, "kicking_personnel", { source: "KICKOFFS", pid: row["PID"], attribute: "KICKER" })
    upsert_player_play_attribute(possession, row["KR"], type, "returning_personnel", { source: "KICKOFFS", pid: row["PID"], attribute: "KR" })

    upsert_play_attribute(possession, row["KGRO"], type, "gross_distance")
    upsert_play_attribute(possession, row["KNET"], type, "net_distance")
    upsert_play_attribute(possession, row["KTB"], type, "touchback")
    upsert_play_attribute(possession, row["KRY"], type, "return_yards")
  end
end
