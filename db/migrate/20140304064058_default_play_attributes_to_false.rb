class DefaultPlayAttributesToFalse < ActiveRecord::Migration
  def change
    change_column :plays, :first_down, :boolean, :default => false
    change_column :plays, :scoring, :boolean, :default => false
    change_column :plays, :conversion, :boolean, :default => false
    change_column :plays, :shotgun, :boolean, :default => false
    change_column :plays, :no_huddle, :boolean, :default => false
    change_column :plays, :trick_play, :boolean, :default => false
  end
end
