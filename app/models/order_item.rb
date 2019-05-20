class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates_presence_of :quantity, :price, :fulfilled
end
