class DropPlayAttributes < ActiveRecord::Migration
  def up
    drop_table :play_attributes
  end

  def down
    create_table "play_attributes", force: true do |t|
      t.integer  "play_id"
      t.string   "attribute_type"
      t.string   "attribute_code"
      t.string   "attribute_value"
      t.integer  "attribute_value_id"
      t.string   "attribute_value_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "play_attributes", ["play_id"], name: "index_play_attributes_on_play_id", using: :btree
  end
end
