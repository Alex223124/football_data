class AddIndexForTeamAbbreviation < ActiveRecord::Migration
  def change
    add_index :teams, :abbreviation
  end
end
