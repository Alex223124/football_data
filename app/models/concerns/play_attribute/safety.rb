class PlayAttribute
  module Safety
    extend ActiveSupport::Concern

    included do
      SAFETY_CODES = {
        forcing_personnel: [:safety]
      }

      ATTRIBUTE_TYPES.merge!(safety: true)
      ATTRIBUTE_CODES.merge!(SAFETY_CODES) { |key, a, b| a + b }
    end
  end
end
