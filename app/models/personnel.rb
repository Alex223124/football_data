class Personnel < ActiveRecord::Base
  belongs_to :possession
  belongs_to :player
  belongs_to :position

  delegate :side_of_ball, :role, :unit, to: :position

  validates :possession, presence: true
  validates :player, presence: true
end
