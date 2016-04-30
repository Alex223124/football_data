class PlayAttribute
  module Rush
    extend ActiveSupport::Concern

    included do
      RUSH_CODES = {
        rush_yards: [:rush],
        rushing_personnel: [:rush]
      }

      ATTRIBUTE_TYPES.merge!(rush: true)
      ATTRIBUTE_CODES.merge!(RUSH_CODES) { |key, a, b| a + b }
    end
  end
end
