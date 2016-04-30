class Play < ActiveRecord::Base
  FIELD_LOCATIONS = [
    "deep_left",
    "deep_middle",
    "deep_right",
    "left_end",
    "left_guard",
    "left_tackle",
    "middle",
    "right_end",
    "right_guard",
    "right_tackle",
    "short_left",
    "short_middle",
    "short_right"
  ]

  enum play_type: [:kickoff, :pass, :punt, :rush, :no_play, :onside_kick, :conversion, :field_goal, :extra_point]
  store_accessor :foreign_keys, :aa

  has_many :events
  has_one :pass

  validates :possession, presence: true
  validates :play_type, presence: true
  validates :first_down, inclusion: { in: [true, false] }
  validates :scoring, inclusion: { in: [true, false] }
  validates :shotgun, inclusion: { in: [true, false] }
  validates :no_huddle, inclusion: { in: [true, false] }
  validates :trick_play, inclusion: { in: [true, false] }
  validates :success, inclusion: { in: [true, false] }
  validates :spike, inclusion: { in: [true, false] }
  validates :knee, inclusion: { in: [true, false] }
  validates :field_location, inclusion: { in: FIELD_LOCATIONS }, allow_nil: true
  validates :yards_gained, inclusion: { in: 0..100 }, allow_nil: true
  validates :aa, numericality: { only_integer: true }, allow_nil: true
end
