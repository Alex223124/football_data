class PlayAttribute
  module Tackle
    extend ActiveSupport::Concern

    included do
      TACKLE_CODES = {
        tackling_personnel: [:tackle],
        tackle_value: [:tackle]
      }

      ATTRIBUTE_TYPES.merge!(tackle: true)
      ATTRIBUTE_CODES.merge!(TACKLE_CODES) { |key, a, b| a + b }
    end
  end
end
