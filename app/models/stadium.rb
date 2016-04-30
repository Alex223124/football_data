class Stadium < ActiveRecord::Base
  has_many :events

  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true
end
