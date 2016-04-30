class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.references :play, index: true
      t.string :type, index: true
      t.hstore :data

      t.timestamps
    end

    execute "CREATE INDEX events_gin_data ON events USING GIN(data)"
  end

  def down
    drop_table :events
  end
end
