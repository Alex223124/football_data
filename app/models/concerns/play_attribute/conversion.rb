class PlayAttribute
  module Conversion
    extend ActiveSupport::Concern

    included do
      CONVERSION_CODES = {
        conversion_success: [:conversion],
        conversion_type: [:conversion],
        passing_personnel: [:conversion],
        rushing_personnel: [:conversion],
        targeted_personnel: [:conversion]
      }

      ATTRIBUTE_TYPES.merge!(conversion: true)
      ATTRIBUTE_CODES.merge!(CONVERSION_CODES) { |key, a, b| a + b }
    end
  end
end
