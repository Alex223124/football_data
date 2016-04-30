require "csv"

after :setup, :positions, :teams do
  puts "Updating Player data"

  CSV.foreach("#{ENV["SOURCE_DATA_DIR"]}/PLAYERS.csv", headers: true) do |row|
    player_id = db[:etl_mappings].where(source_type: "player", source_id: row["PLAYER"], target_type: "player").first || {}
    player_id = player_id.fetch(:target_id, nil)
    player = Player.find(player_id) if player_id
    player ||= Player.new(aa: row["PLAYER"])
    player.update_attributes!({
      first_name: row["FNAME"],
      last_name: row["LNAME"],
      height: row["HEIGHT"],
      weight: row["WEIGHT"],
      birth_year: row["YOB"],
      draft_position: row["DPOS"],
      college: row["COL"],
      college_division: row["DV"],
      rookie_year: row["START"],
      primary_position: Position.find_by(abbreviation: row["POS1"]),
      current_team: Team.find_by(abbreviation: row["CTEAM"])
    })

    if db[:etl_mappings].where(source_type: "player", source_id: row["PLAYER"], target_type: "player", target_id: player.id).count == 0
      db[:etl_mappings].insert(source_type: "player", source_id: row["PLAYER"], target_type: "player", target_id: player.id)
    end
  end
end
