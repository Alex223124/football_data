class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string     :first_name
      t.string     :last_name
      t.references :current_team, index: true
      t.references :primary_position, index: true
      t.integer    :height
      t.integer    :weight
      t.integer    :birth_year
      t.integer    :draft_position
      t.string     :college
      t.integer    :rookie_year
      t.string     :player_code

      t.timestamps
    end
  end
end
