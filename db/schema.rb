# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160430040205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "etl_mappings", id: false, force: true do |t|
    t.text    "source_type"
    t.text    "source_id"
    t.text    "target_type"
    t.integer "target_id"
  end

  add_index "etl_mappings", ["source_id"], name: "etl_mappings_source_id_index", using: :btree
  add_index "etl_mappings", ["source_type", "source_id", "target_type", "target_id"], name: "etl_mappings_source_type_source_id_target_type_target_id_index", unique: true, using: :btree
  add_index "etl_mappings", ["target_id"], name: "etl_mappings_target_id_index", using: :btree

  create_table "events", force: true do |t|
    t.string   "type"
    t.hstore   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "primary_player_id"
    t.integer  "secondary_player_id"
    t.integer  "tertiary_player_id"
    t.integer  "game_id"
    t.integer  "possession_id"
    t.integer  "stadium_id"
    t.integer  "offense_team_id"
    t.integer  "defense_team_id"
    t.integer  "visitor_team_id"
    t.integer  "home_team_id"
    t.string   "field_location"
    t.integer  "yards_gained"
    t.boolean  "first_down"
    t.boolean  "scoring"
    t.boolean  "shotgun"
    t.boolean  "no_huddle"
    t.boolean  "success"
    t.boolean  "spike"
    t.boolean  "knee"
  end

  add_index "events", ["data"], name: "events_gin_data", using: :gin
  add_index "events", ["defense_team_id"], name: "index_events_on_defense_team_id", using: :btree
  add_index "events", ["game_id"], name: "index_events_on_game_id", using: :btree
  add_index "events", ["home_team_id"], name: "index_events_on_home_team_id", using: :btree
  add_index "events", ["id"], name: "index_events_on_id", using: :btree
  add_index "events", ["offense_team_id"], name: "index_events_on_offense_team_id", using: :btree
  add_index "events", ["primary_player_id"], name: "index_events_on_primary_player_id", using: :btree
  add_index "events", ["secondary_player_id"], name: "index_events_on_secondary_player_id", using: :btree
  add_index "events", ["tertiary_player_id"], name: "index_events_on_tertiary_player_id", using: :btree
  add_index "events", ["visitor_team_id"], name: "index_events_on_visitor_team_id", using: :btree

  create_table "games", force: true do |t|
    t.integer  "season"
    t.integer  "week"
    t.string   "day"
    t.integer  "temperature"
    t.integer  "humidity"
    t.integer  "wind_speed"
    t.string   "wind_direction"
    t.string   "conditions"
    t.integer  "visitor_points"
    t.integer  "home_points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "foreign_keys"
    t.integer  "time_of_day"
    t.boolean  "super_bowl",     default: false
  end

  add_index "games", ["foreign_keys"], name: "games_gin_foreign_keys", using: :gin
  add_index "games", ["id"], name: "index_games_on_id", using: :btree
  add_index "games", ["season"], name: "index_games_on_season", using: :btree
  add_index "games", ["week"], name: "index_games_on_week", using: :btree

  create_table "personnels", force: true do |t|
    t.integer  "possession_id"
    t.integer  "player_id"
    t.integer  "position_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personnels", ["player_id"], name: "index_personnels_on_player_id", using: :btree
  add_index "personnels", ["position_id"], name: "index_personnels_on_position_id", using: :btree
  add_index "personnels", ["possession_id"], name: "index_personnels_on_possession_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "current_team_id"
    t.integer  "primary_position_id"
    t.integer  "height"
    t.integer  "weight"
    t.integer  "birth_year"
    t.integer  "draft_position"
    t.string   "college"
    t.integer  "rookie_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "foreign_keys"
    t.string   "college_division"
  end

  add_index "players", ["current_team_id"], name: "index_players_on_current_team_id", using: :btree
  add_index "players", ["foreign_keys"], name: "index_players_on_foreign_keys", using: :btree
  add_index "players", ["foreign_keys"], name: "players_gin_foreign_keys", using: :gin
  add_index "players", ["primary_position_id"], name: "index_players_on_primary_position_id", using: :btree

  create_table "positions", force: true do |t|
    t.string   "abbreviation"
    t.string   "unit"
    t.string   "position"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "side_of_ball"
  end

  create_table "possessions", force: true do |t|
    t.integer  "length"
    t.integer  "quarter"
    t.integer  "minutes"
    t.integer  "seconds"
    t.integer  "offense_points"
    t.integer  "defense_points"
    t.integer  "offense_timeouts"
    t.integer  "defense_timeouts"
    t.integer  "down"
    t.integer  "yards_to_go"
    t.integer  "yards_from_goal"
    t.integer  "zone"
    t.integer  "drive_sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "foreign_keys"
  end

  add_index "possessions", ["foreign_keys"], name: "possessions_gin_foreign_keys", using: :gin

  create_table "stadiums", force: true do |t|
    t.string   "name"
    t.integer  "elevation"
    t.string   "surface"
    t.string   "stadium_type"
    t.string   "surface_name"
    t.string   "surface_type"
    t.integer  "capacity"
    t.integer  "expanded_capacity"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "abbreviation"
    t.string   "conference"
    t.string   "division"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["abbreviation"], name: "index_teams_on_abbreviation", using: :btree

end
