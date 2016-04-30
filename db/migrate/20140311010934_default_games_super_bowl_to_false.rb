class DefaultGamesSuperBowlToFalse < ActiveRecord::Migration
  def change
    change_column_default :games, :super_bowl, false
  end
end
