class RemoveConversionFromPlays < ActiveRecord::Migration
  def change
    remove_column :plays, :conversion, :boolean
  end
end
