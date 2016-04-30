class AddForeignKeysToGamePlayAndPossession < ActiveRecord::Migration
  def change
    add_column :games, :foreign_keys, :hstore 
    add_column :plays, :foreign_keys, :hstore 
    add_column :possessions, :foreign_keys, :hstore 
  end
end
