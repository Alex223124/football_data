class Possession < ActiveRecord::Base
  QUARTERS = {
    "1"   => "First",
    "2"   => "Second",
    "3"   => "Third",
    "4"   => "Fourth",
    "OT"  => "Overtime",
    "OT2" => "Second Overtime"
  }

  ZONES = {
    "1" => "To Own 20",
    "2" => "Own 20 to 40",
    "3" => "Midfield",
    "4" => "Opponent 20 to 40",
    "5" => "Redzone"
  }

  enum zone: [:not_applicable, :own_0_20, :own_21_40, :midfield, :opponent_21_40, :redzone]
  store_accessor :foreign_keys, :aa

  has_many :events

  validates :length, numericality: { only_integer: true }
  validates :quarter, inclusion: { in: 1..6 }
  validates :minutes, inclusion: { in: 0..15 }
  validates :seconds, inclusion: { in: 0..59 }
  validates :offense_points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :defense_points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :offense_timeouts, inclusion: { in: 0..3 }
  validates :defense_timeouts, inclusion: { in: 0..3 }
  validates :down, inclusion: { in: 0..4 }
  validates :yards_to_go, inclusion: { in: 0..99 }
  validates :yards_from_goal, inclusion: { in: 1..99 }, allow_nil: true
  validates :zone, presence: true
  validates :drive_sequence, numericality: { only_integer: true }
  validates :aa, numericality: { only_integer: true }, allow_nil: true
end
