class UpdateEventAttributes < ActiveRecord::Migration
  def change
    remove_column :events, :play_id, :integer

    add_column :events, :field_location, :string
    add_column :events, :yards_gained, :int
    add_column :events, :first_down, :boolean
    add_column :events, :scoring, :boolean
    add_column :events, :shotgun, :boolean
    add_column :events, :no_huddle, :boolean
    add_column :events, :success, :boolean
    add_column :events, :spike, :boolean
    add_column :events, :knee, :boolean
  end
end
