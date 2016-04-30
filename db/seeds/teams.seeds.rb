require "csv"

after :setup do
  puts "Updating Team data"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/teams.csv", headers: true) do |row|
    team = Team.find_or_create_by(name: row["name"])
    team.update_attributes!(row.to_hash)

    if db[:etl_mappings].where(source_type: "team", source_id: row["abbreviation"], target_type: "team", target_id: team.id).count == 0
      db[:etl_mappings].insert(source_type: "team", source_id: row["abbreviation"], target_type: "team", target_id: team.id)
    end
  end
end
