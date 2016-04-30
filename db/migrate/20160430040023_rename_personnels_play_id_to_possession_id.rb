class RenamePersonnelsPlayIdToPossessionId < ActiveRecord::Migration
  def change
    rename_column :personnels, :play_id, :possession_id
  end
end
