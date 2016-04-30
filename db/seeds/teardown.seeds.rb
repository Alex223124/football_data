require "#{Rails.root}/db/seeds/seeds_helper"

# update if tackles is no longer the last seed
after :setup, :players, :possessions, :tackles do
  db.drop_table?(:etl_mappings)

  log_file.close
end
