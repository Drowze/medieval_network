class ItemSlot < ApplicationRecord
  belongs_to :wizard
  belongs_to :item

  validates :quantity, presence: true
  validates :item_id, uniqueness: { scope: :wizard_id }

  scope :item_name, ->(name) { joins(:item).where(items: { name: name }) }
end
