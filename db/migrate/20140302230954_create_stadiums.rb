class CreateStadiums < ActiveRecord::Migration
  def change
    create_table :stadiums do |t|
      t.string   :name
      t.integer  :elevation
      t.string   :surface
      t.string   :stadium_type
      t.string   :surface_name
      t.string   :surface_type
      t.integer  :capacity
      t.integer  :expanded_capacity
      t.string   :city
      t.string   :state

      t.timestamps
    end
  end
end
