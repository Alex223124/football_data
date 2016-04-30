class Event < ActiveRecord::Base
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

  belongs_to :game
  belongs_to :stadium
  belongs_to :possession
  belongs_to :home_team, class_name: "Team"
  belongs_to :visitor_team, class_name: "Team"
  belongs_to :offense_team, class_name: "Team"
  belongs_to :defense_team, class_name: "Team"
  belongs_to :primary_player, class_name: "Player"
  belongs_to :secondary_player, class_name: "Player"
  belongs_to :tertiary_player, class_name: "Player"

  # store_accessor :data, :foo

  validates :game, presence: true
  validates :stadium, presence: true
  validates :home_team, presence: true
  validates :visitor_team, presence: true
  validates :offense_team, presence: true
  validates :defense_team, presence: true
  validates :possession, presence: true
  validates :first_down, inclusion: { in: [true, false] }
  validates :scoring, inclusion: { in: [true, false] }
  validates :shotgun, inclusion: { in: [true, false] }
  validates :no_huddle, inclusion: { in: [true, false] }
  validates :success, inclusion: { in: [true, false] }
  validates :spike, inclusion: { in: [true, false] }
  validates :knee, inclusion: { in: [true, false] }
  validates :field_location, inclusion: { in: FIELD_LOCATIONS }, allow_nil: true
  validates :yards_gained, inclusion: { in: 0..100 }, allow_nil: true
end
