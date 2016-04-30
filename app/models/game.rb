class Game < ActiveRecord::Base
  WIND_DIRECTIONS = ["CALM", "E", "ENE", "ESE", "N", "NE", "NNE", "NNW", "NW",
                     "S", "SE", "SSE", "SSW", "SW", "W", "WNW", "WSW"]

  CONDITIONS = ["Chance Rain", "Clear", "Closed Roof", "Cloudy", "Cold",
                "Covered Roof", "Dome", "Fair", "Flurries", "Foggy", "Hazy",
                "Light Rain", "Light Snow", "Mostly Cloudy", "Mostly Sunny",
                "Partly Cloudy", "Partly Sunny", "Rain", "Snow", "Sunny",
                "Thunderstorms", "Windy"]

  WEEKS = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12",
           "13", "14", "15", "16", "17", "Wildcard", "Divisional",
           "Championship", "Super Bowl"]

  enum time_of_day: [:early, :late, :night]
  store_accessor :foreign_keys, :aa

  has_many :events

  validates :season, inclusion: { in: 1900..2100 }
  validates :week, inclusion: { in: 1..21 }
  validates :day, inclusion: { in: ["SUN", "MON", "WED", "THU", "FRI", "SAT"] }
  validates :temperature, numericality: { only_integer: true }, allow_nil: true
  validates :humidity, inclusion: { in: 0..100 }, allow_nil: true
  validates :wind_speed, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :wind_direction, inclusion: { in: WIND_DIRECTIONS }, allow_nil: true
  validates :conditions, inclusion: { in: CONDITIONS }, allow_nil: true
  validates :visitor_points, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :home_points, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :aa, numericality: { only_integer: true }, allow_nil: true
end
