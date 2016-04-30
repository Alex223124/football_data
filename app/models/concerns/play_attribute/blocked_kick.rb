class PlayAttribute
  module BlockedKick
    extend ActiveSupport::Concern

    included do
      BLOCKED_KICK_CODES = {
        blocking_personnel: [:blocked_kick],
        recovering_personnel: [:blocked_kick]
      }

      ATTRIBUTE_TYPES.merge!(blocked_kick: true)
      ATTRIBUTE_CODES.merge!(BLOCKED_KICK_CODES) { |key, a, b| a + b }
    end
  end
end
