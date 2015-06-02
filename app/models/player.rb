class Player < ActiveRecord::Base
  belongs_to :game

  validates :name,
    presence: true,
      length: { maximum: 100 }

  validates :points,
    presence: true,
numericality: { only_integer: true }

  validates :game,
    presence: true

end