class PlayAttribute
  module ExtraPoint
    extend ActiveSupport::Concern

    included do
      EXTRA_POINT_CODES = {
        kick_distance: [:extra_point],
        kick_good: [:extra_point],
        kicking_personnel: [:extra_point]
      }

      ATTRIBUTE_TYPES.merge!(extra_point: true)
      ATTRIBUTE_CODES.merge!(EXTRA_POINT_CODES) { |key, a, b| a + b }
    end
  end
end
