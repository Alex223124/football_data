class AddIndexForGamesSeasonAndWeek < ActiveRecord::Migration
  def change
    add_index :games, :season
    add_index :games, :week
  end
end
