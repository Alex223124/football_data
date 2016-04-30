require "csv"

after :setup do
  puts "Updating Stadium data"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/stadiums.csv", headers: true) do |row|
    record = Stadium.find_or_create_by(name: row["name"])
    record.update_attributes!(row.to_hash)
  end
end
