class AddSuperBowlToGames < ActiveRecord::Migration
  def change
    add_column :games, :super_bowl, :boolean
  end
end
