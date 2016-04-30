class AddCollegeDivisionToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :college_division, :string
  end
end
