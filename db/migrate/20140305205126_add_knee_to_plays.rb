class AddKneeToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :knee, :boolean
  end
end
