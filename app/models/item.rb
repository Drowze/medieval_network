class Item < ApplicationRecord
  validates :name, :value, presence: true
end
