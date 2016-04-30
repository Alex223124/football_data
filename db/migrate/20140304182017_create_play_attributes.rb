class CreatePlayAttributes < ActiveRecord::Migration
  def change
    create_table :play_attributes do |t|
      t.references :play, index: true
      t.string :attribute_type
      t.string :attribute_code
      t.string :attribute_value
      t.integer :attribute_value_id
      t.string :attribute_value_type

      t.timestamps
    end
  end
end
