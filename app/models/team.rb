class Team < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
  validates :abbreviation, presence: true, uniqueness: true
  validates :conference, presence: true
  validates :division, presence: true

  alias_attribute :abbr, :abbreviation

  def full_name
    "#{city} #{name}"
  end
end
