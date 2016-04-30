class DropRoleUnitFromPersonnels < ActiveRecord::Migration
  def change
    remove_column :personnels, :role, :string
    remove_column :personnels, :unit, :string
  end
end
