class AddPersonnelsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :primary_personnel_id, :integer, index: true
    add_column :events, :secondary_personnel_id, :integer, index: true
    add_column :events, :tertiary_personnel_id, :integer, index: true
  end
end
