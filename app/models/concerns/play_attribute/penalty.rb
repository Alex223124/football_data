class PlayAttribute
  module Penalty
    extend ActiveSupport::Concern

    included do
      PENALTY_CATEGORIES = [
       "defensive_line",
       "defensive_secondary",
       "execution",
       "false_start",
       "dumb",
       "offensive_holding",
       "other",
       "poor_fundamentals"
      ]

      PENALTY_ACTIONS = [
        "declined",
        "offsetting",
        "accepted"
      ]

      PENALTY_CODES = {
        penalized_personnel: [:penalty],
        penalized_team: [:penalty],
        penalty_action: [:penalty],
        penalty_category: [:penalty],
        penalty_description: [:penalty],
        penalty_yards: [:penalty]
      }

      ATTRIBUTE_TYPES.merge!(penalty: true)
      ATTRIBUTE_CODES.merge!(PENALTY_CODES) { |key, a, b| a + b }

      validates :attribute_value, inclusion: { in: PENALTY_CATEGORIES }, if: "attribute_code == 'penalty_category'"
      validates :attribute_value, inclusion: { in: PENALTY_ACTIONS }, if: "attribute_code == 'penalty_action'"
    end
  end
end
