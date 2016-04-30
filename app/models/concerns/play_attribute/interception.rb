class PlayAttribute
  module Interception
    extend ActiveSupport::Concern

    included do
      INTERCEPTION_CODES = {
        intercepting_personnel: [:interception],
        return_yards: [:interception]
      }

      ATTRIBUTE_TYPES.merge!(interception: true)
      ATTRIBUTE_CODES.merge!(INTERCEPTION_CODES) { |key, a, b| a + b }
    end
  end
end
