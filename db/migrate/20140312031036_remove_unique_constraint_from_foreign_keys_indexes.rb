class RemoveUniqueConstraintFromForeignKeysIndexes < ActiveRecord::Migration
  def up
    remove_index :plays, :foreign_keys
    remove_index :players, :foreign_keys
    add_index :plays, :foreign_keys
    add_index :players, :foreign_keys
  end

  def down
    remove_index :play, :foreign_keys
    remove_index :players, :foreign_keys
    add_index :plays, :foreign_keys, unique: true
    add_index :players, :foreign_keys, unique: true
  end
end
