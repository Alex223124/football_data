class CreatePossessions < ActiveRecord::Migration
  def change
    create_table :possessions do |t|
      t.references :offense_team, index: true
      t.references :defense_team, index: true
      t.integer    :length
      t.integer    :quarter
      t.integer    :minutes
      t.integer    :seconds
      t.integer    :offense_points
      t.integer    :defense_points
      t.integer    :offense_timeouts
      t.integer    :defense_timeouts
      t.integer    :down
      t.integer    :yards_to_go
      t.integer    :yards_from_goal
      t.integer    :zone
      t.integer    :game_id
      t.integer    :drive_sequence

      t.timestamps
    end
  end
end
