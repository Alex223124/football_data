class CreatePersonnels < ActiveRecord::Migration
  def change
    create_table :personnels do |t|
      t.references :play, index: true
      t.references :player, index: true
      t.references :position, index: true
      t.string     :role
      t.string     :unit
      t.string     :sob

      t.timestamps
    end
  end
end
