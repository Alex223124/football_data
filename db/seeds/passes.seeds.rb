require "csv"
require "#{Rails.root}/db/seeds/seeds_helper"

after :setup, :players, :possessions do
  puts "Updating Passes data..."

  db.drop_table?(:etl_comps)

  # completions
  puts "- Loading Completion data..."
  db.create_table :etl_comps do
    primary_key :pid, index: { unique: true }
  end

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/COMPS.csv", headers: true) do |row|
    db[:etl_comps].insert(pid: row["PID"])
  end

  puts "- Processing Pass data..."

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/PASS.csv", headers: true) do |row|
    possession_id = fetch_possession_id(row["PID"])
    next if possession_id.nil?

    possession = Possession.find(possession_id)

    passer_personnel = find_personnel(possession, row["PSR"], { source: "PASS", pid: row["PID"], attribute: "PSR" })
    target_personnel = find_personnel(possession, row["TRG"], { source: "PASS", pid: row["PID"], attribute: "TRG" })

    completion = db[:etl_comps].where(pid: row["PID"]).count > 0

    Pass.create!(
      play: p,
      passer_personnel: passer_personnel,
      target_personnel: target_personnel,
      yards: row["YDS"],
      location: parse_field_location(row["LOC"]),
      completion: completion
    )
  end

  db.drop_table?(:etl_comps)
end
