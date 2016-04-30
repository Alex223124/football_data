class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer    :season
      t.integer    :week
      t.string     :day
      t.references :visitor_team, index: true
      t.references :home_team, index: true
      t.references :stadium, index: true
      t.integer    :temperature
      t.integer    :humidity
      t.integer    :wind_speed
      t.string     :wind_direction
      t.string     :conditions
      t.integer    :visitor_points
      t.integer    :home_points

      t.timestamps
    end
  end
end
