class PlayAttribute
  module Kickoff
    extend ActiveSupport::Concern

    included do
      KICKOFF_CODES = {
        gross_distance: [:kickoff],
        kicking_personnel: [:kickoff],
        net_distance: [:kickoff],
        return_yards: [:kickoff],
        returning_personnel: [:kickoff],
        touchback: [:kickoff]
      }

      ATTRIBUTE_TYPES.merge!(kickoff: true)
      ATTRIBUTE_CODES.merge!(KICKOFF_CODES) { |key, a, b| a + b }
    end
  end
end
