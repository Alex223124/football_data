class PlayAttribute
  module Punt
    extend ActiveSupport::Concern

    included do
      PUNT_CODES = {
        fair_catch: [:punt],
        gross_distance: [:punt],
        kicking_personnel: [:punt],
        net_distance: [:punt],
        return_yards: [:punt],
        returning_personnel: [:punt],
        touchback: [:punt]
      }

      ATTRIBUTE_TYPES.merge!(punt: true)
      ATTRIBUTE_CODES.merge!(PUNT_CODES) { |key, a, b| a + b }
    end
  end
end
