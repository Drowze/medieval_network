class Wizard < ApplicationRecord
  has_many :item_slots
  has_many :items, through: :item_slots

  validates :location_x, :location_y, numericality: { in: -90..90 }
  validates :name, :gender, presence: true
  validates :gold, numericality: { greater_than_or_equal_to: 0 }
  enum gender: {
    male: 0,
    female: 1
  }
end
