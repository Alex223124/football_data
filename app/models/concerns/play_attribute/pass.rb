class PlayAttribute
  module Pass
    extend ActiveSupport::Concern

    included do
      PASS_CODES = {
        pass_yards: [:pass],
        passing_personnel: [:pass],
        targeted_personnel: [:pass],
      }

      ATTRIBUTE_TYPES.merge!(pass: true)
      ATTRIBUTE_CODES.merge!(PASS_CODES) { |key, a, b| a + b }
    end
  end
end
