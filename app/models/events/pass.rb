class Pass < Event
  LOCATIONS = [
    "deep_left",
    "deep_middle",
    "deep_right",
    "short_left",
    "short_middle",
    "short_right"
  ]

  hstore_accessor :data,
    yards: :integer,
    location: :string,
    completion: :integer,
    pass_touchdown: :integer,
    pass_interception: :integer

  belongs_to :passer, class_name: "Player", foreign_key: "primary_player_id"
  belongs_to :target, class_name: "Player", foreign_key: "secondary_player_id"

  # validates :passer, presence: true
  validates :yards, numericality: { only_integer: true }, allow_nil: true
  validates :location, inclusion: LOCATIONS, allow_nil: true
  validates :completion, :pass_touchdown, :pass_interception, inclusion: [0, 1], allow_nil: true
end
