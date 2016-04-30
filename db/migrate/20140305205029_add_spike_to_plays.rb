class AddSpikeToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :spike, :boolean
  end
end
