class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.boolean    :first_down
      t.integer    :yards_gained
      t.boolean    :scoring
      t.boolean    :conversion
      t.boolean    :shotgun
      t.boolean    :no_huddle
      t.boolean    :trick_play
      t.string     :field_location
      t.string     :play_type
      t.references :possession, index: true

      t.timestamps
    end
  end
end
