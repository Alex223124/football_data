class AddBtreeIndexToPlayersForeignKeys < ActiveRecord::Migration
  def change
    add_index :players, :foreign_keys, unique: true
  end
end
