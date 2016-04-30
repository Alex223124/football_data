class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string   :abbreviation
      t.string   :unit
      t.string   :sob
      t.string   :position
      t.string   :role

      t.timestamps
    end
  end
end
