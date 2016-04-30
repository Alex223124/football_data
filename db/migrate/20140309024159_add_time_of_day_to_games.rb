class AddTimeOfDayToGames < ActiveRecord::Migration
  def change
    add_column :games, :time_of_day, :integer
  end
end
