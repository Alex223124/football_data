class AddIndexToGamesAndEvents < ActiveRecord::Migration
  def change
    add_index :events, :id
    add_index :events, :primary_player_id
    add_index :events, :secondary_player_id
    add_index :events, :tertiary_player_id
    add_index :events, :offense_team_id
    add_index :events, :defense_team_id
    add_index :events, :home_team_id
    add_index :events, :visitor_team_id
    add_index :events, :game_id
    add_index :games,  :id
  end
end
