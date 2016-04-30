class ChangePlaysPlayTypeToInteger < ActiveRecord::Migration
  def up
    remove_column :plays, :play_type
    add_column    :plays, :play_type, :integer
  end

  def down
    remove_column :plays, :play_type
    add_column    :plays, :play_type, :string
  end
end
