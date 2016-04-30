class PlayAttribute
  module PassDefend
    extend ActiveSupport::Concern

    included do
      PASS_DEFEND_CODES = {
        pass_defending_personnel: [:pass_defend]
      }

      ATTRIBUTE_TYPES.merge!(pass_defend: true)
      ATTRIBUTE_CODES.merge!(PASS_DEFEND_CODES) { |key, a, b| a + b }
    end
  end
end
