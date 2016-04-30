class PlayAttribute
  module Fumble
    extend ActiveSupport::Concern

    included do
      FUMBLE_CODES = {
        fumbling_personnel: [:fumble],
        recovering_personnel: [:fumble],
        forcing_personnel: [:fumble],
        return_yards: [:fumble]
      }

      ATTRIBUTE_TYPES.merge!(fumble: true)
      ATTRIBUTE_CODES.merge!(FUMBLE_CODES) { |key, a, b| a + b }
    end
  end
end
