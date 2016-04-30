class Player < ActiveRecord::Base
  store_accessor :foreign_keys, :aa

  belongs_to :primary_position, class_name: "Position"
  belongs_to :current_team, class_name: "Team"
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :primary_position, presence: true
  validates :height, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :weight, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :birth_year, inclusion: { in: 1900..2100 }
  validates :draft_position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :rookie_year, inclusion: { in: 1900..2100 }
  validates :aa, format: { with: /[A-Z]{2}-[0-9]{4}/ }, allow_nil: true

  # Used by ransack to search by Player full name
  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new('||', Arel::Nodes::InfixOperation.new('||',
      parent.table[:first_name], ' '), parent.table[:last_name])
  end
end
