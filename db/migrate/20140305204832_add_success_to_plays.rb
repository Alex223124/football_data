class AddSuccessToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :success, :boolean
  end
end
