class DropForeignKeysFromDimensions < ActiveRecord::Migration
  def change
    remove_column :possessions, :game_id, :integer
    remove_column :possessions, :offense_team_id, :integer
    remove_column :possessions, :defense_team_id, :integer
    remove_column :games, :visitor_team_id, :integer
    remove_column :games, :home_team_id, :integer
    remove_column :games, :stadium_id, :integer
    remove_column :plays, :possession_id, :integer

    rename_column :events, :primary_personnel_id, :primary_player_id
    rename_column :events, :secondary_personnel_id, :secondary_player_id
    rename_column :events, :tertiary_personnel_id, :tertiary_player_id

    add_column    :events, :game_id, :integer
    add_column    :events, :possession_id, :integer
    add_column    :events, :stadium_id, :integer
    add_column    :events, :offense_team_id, :integer
    add_column    :events, :defense_team_id, :integer
    add_column    :events, :visitor_team_id, :integer
    add_column    :events, :home_team_id, :integer
  end
end
