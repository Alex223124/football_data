class AddBtreeIndexToPlaysForeignKeys < ActiveRecord::Migration
  def change
    add_index :plays, :foreign_keys, unique: true
  end
end
