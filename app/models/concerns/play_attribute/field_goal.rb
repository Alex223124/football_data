class PlayAttribute
  module FieldGoal
    extend ActiveSupport::Concern

    included do
      FIELD_GOAL_CODES = {
        kick_distance: [:field_goal],
        kick_good: [:field_goal],
        kicking_personnel: [:field_goal]
      }

      ATTRIBUTE_TYPES.merge!(field_goal: true)
      ATTRIBUTE_CODES.merge!(FIELD_GOAL_CODES) { |key, a, b| a + b }
    end
  end
end
