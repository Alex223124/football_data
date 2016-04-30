def upsert_player_play_attribute(possession, player_fk, type, code, source_info = {})
  unless player_fk == "XX-0000"
    player_id = db[:etl_mappings].where(source_type: "player", source_id: player_fk).first

    if player_id.nil?
      puts "!!! Data mismatch: #{[source_info[:source], "PID", source_info[:pid], source_info[:attribute], player_fk].join(",")}"
      log_data(source: source_info[:source],
               id_type: "PID",
               id_value: source_info[:pid],
               attribute_type: source_info[:attribute],
               attribute_value: player_fk)
      return
    else
      player_id = player_id[:player_id]
    end

    return if player_id.nil?

    player = Player.find(player_id)
    personnel = Personnel.find_or_create_by(possession: possession, player: player)

#     play_attribute = PlayAttribute.find_or_create_by(play: p, attribute_type: type, attribute_code: code)
#     play_attribute.value = personnel
#     play_attribute.save!
  end
end

def upsert_play_attribute(possession, value, type, code)
  # play_attribute = PlayAttribute.find_or_create_by(possession: possession, attribute_type: type, attribute_code: code)
  # play_attribute.update_attributes!(value: value)
end

def parse_stadium(stadium)
  stadium = stadium.downcase
  ["stadium", "field", "park", "coliseum"].each do |name_type|
    stadium = stadium.partition(name_type).first.strip
  end
  stadium = "m&t bank" if stadium == "m & t bank"
  stadium = "sports authority" if stadium == "sport authority"
  stadium
end

def parse_day(day)
  case day
  when "TN" then "THU"
  when "SN", "SB" then "SUN"
  when "MN" then "SUN"
  else day
  end
end

def cleanse_attribute(attr, type: :string, upcase: false)
  attr = attr.to_s.strip
  attr = attr.gsub(/NULL/, "")
  attr = attr.gsub(/VAR/, "")
  attr = attr.gsub(/NA/, "")
  attr = attr.gsub(/\\\\N/, "")
  attr = attr.gsub(/\\N/, "")
  attr = attr.gsub(/\\/, "")
  attr = attr.empty? ? nil : attr
  attr = attr.upcase if !attr.nil? && upcase
  attr = attr.to_i if !attr.nil? && type == :int
  attr
end

def db
  @db ||= Sequel.connect(ENV["DATABASE_URL"] || "postgres://localhost/#{Rails.application.class.parent_name.parameterize}_#{ENV["RAILS_ENV"] || "development"}")
end

def log_file
  @log_file ||= begin
    log_file_path = ENV["ETL_LOG_FILE"]
    # File.delete(log_file_path) if File.exist?(log_file_path)
    File.open(log_file_path, "a")
  end
end

def log_data(source: "", id_type: "", id_value: "", attribute_type: "", attribute_value: "")
  log_file.write([source, id_type, id_value, attribute_type, attribute_value, "\n"].join(","))
end

def find_player(player_fk, source_info)
  return nil if player_fk == "XX-0000"

  player_id = db[:etl_player_mappings].where(player: player_fk).first

  if player_id.nil?
    puts "!!! Data mismatch: #{[source_info[:source], "PID", source_info[:pid], source_info[:attribute], player_fk].join(",")}"
    log_data(source: source_info[:source],
              id_type: "PID",
              id_value: source_info[:pid],
              attribute_type: source_info[:attribute],
              attribute_value: player_fk)
    return nil
  else
    Player.find(player_id[:player_id])
  end
end

def find_personnel(possession, player_id, source_info)
  if player = find_player(player_id, source_info)
    Personnel.find_or_create_by(possession: possession, player: player)
  end
end

def parse_field_location(loc)
  case loc.to_s.downcase
  when "dl" then "deep_left"
  when "dm" then "deep_middle"
  when "dr" then "deep_right"
  when "le" then "left_end"
  when "lg" then "left_guard"
  when "lt" then "left_tackle"
  when "md" then "middle"
  when "re" then "right_end"
  when "rg" then "right_guard"
  when "rt" then "right_tackle"
  when "sl" then "short_left"
  when "sm" then "short_middle"
  when "sr" then "short_right"
  else nil
  end
end

def parse_play_type(play_type)
  play_type = begin
    case play_type.to_s.downcase
    when "conv" then "Conversion"
    when "fgxp" then "PointsKick"
    when "koff" then "Kickoff"
    when "nopl" then "NoPlay"
    when "onsd" then "OnsideKick"
    when "pass" then "Pass"
    when "punt" then "Punt"
    when "rush" then "Rush"
    else nil
    end
  end
end

def fetch_possession_id(pid)
  possession_id = db[:etl_mappings].where(source_type: "pid", source_id: pid, target_type: "possession").try(:first) || {}
  possession_id.fetch(:target_id, nil)
end
