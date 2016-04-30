class AddIndexForForeignKeys < ActiveRecord::Migration
  def up
    execute "CREATE INDEX games_gin_foreign_keys ON games USING GIN(foreign_keys)"
    execute "CREATE INDEX players_gin_foreign_keys ON players USING GIN(foreign_keys)"
    execute "CREATE INDEX plays_gin_foreign_keys ON plays USING GIN(foreign_keys)"
    execute "CREATE INDEX possessions_gin_foreign_keys ON possessions USING GIN(foreign_keys)"
  end

  def down
    execute "DROP INDEX games_gin_foreign_keys"
    execute "DROP INDEX players_gin_foreign_keys"
    execute "DROP INDEX plays_gin_foreign_keys"
    execute "DROP INDEX possessions_gin_foreign_keys"
  end
end
