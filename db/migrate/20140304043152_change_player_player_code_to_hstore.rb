class ChangePlayerPlayerCodeToHstore < ActiveRecord::Migration
  def up
    remove_column :players, :player_code, :string
    add_column :players, :foreign_keys, :hstore 
  end

  def down
    remove_column :players, :foreign_keys, :hstore 
    add_column :players, :player_code, :string
  end
end
