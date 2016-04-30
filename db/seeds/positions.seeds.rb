require "csv"

after :setup do
  puts "Updating Position data"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/positions.csv", headers: true) do |row|
    record = Position.find_or_create_by(abbreviation: row["abbreviation"])

    row_hash = row.to_hash
    row_hash["side_of_ball"] = row_hash["side_of_ball"].parameterize.underscore.to_sym

    record.update_attributes!(row_hash)
  end
end
