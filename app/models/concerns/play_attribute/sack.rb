class PlayAttribute
  module Sack
    extend ActiveSupport::Concern

    included do
      SACK_CODES = {
        quarterback: [:sack],
        sacking_personnel: [:sack],
        sack_value: [:sack],
        yards_lost: [:sack]
      }

      ATTRIBUTE_TYPES.merge!(sack: true)
      ATTRIBUTE_CODES.merge!(SACK_CODES) { |key, a, b| a + b }
    end
  end
end
