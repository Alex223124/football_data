class ChangeSobToSideOfBallEnum < ActiveRecord::Migration
  def up
    remove_column :personnels, :sob
    remove_column :positions,  :sob
    add_column    :positions,  :side_of_ball, :integer
  end

  def down
    remove_column :positions,  :side_of_ball
    add_column    :personnels, :sob, :string
    add_column    :positions,  :sob, :string
  end
end
