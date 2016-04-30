class Position < ActiveRecord::Base
  enum side_of_ball: [:offense, :defense, :special_teams]

  has_many :players

  validates :abbreviation, presence: true
  validates :unit, presence: true
  validates :position, presence: true
end
