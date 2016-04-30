require "#{Rails.root}/db/seeds/seeds_helper"

db.drop_table?(:etl_mappings)

db.create_table :etl_mappings do
  String  :source_type
  String  :source_id, index: true
  String  :target_type
  Integer :target_id, index: true

  index [:source_type, :source_id, :target_type, :target_id], unique: true
end

puts "Loading Player mapping data"

query = "SELECT
           players.foreign_keys -> 'aa' as player,
           players.id as player_id
         FROM
           players"

results = ActiveRecord::Base.connection.execute(query)

results.each do |result|
  db[:etl_mappings].insert(source_type: "player", source_id: result["player"], target_type: "player", target_id: result["player_id"])
end
