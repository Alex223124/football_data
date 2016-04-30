class DropPlays < ActiveRecord::Migration
  def up
    drop_table :plays
  end

  def down
    create_table :plays do |t|
      t.boolean  :first_down,     default: false
      t.integer  :yards_gained
      t.boolean  :scoring,        default: false
      t.boolean  :shotgun,        default: false
      t.boolean  :no_huddle,      default: false
      t.boolean  :trick_play,     default: false
      t.string   :field_location
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :play_type
      t.hstore   :foreign_keys
      t.boolean  :success
      t.boolean  :spike
      t.boolean  :knee
    end
  end
end
