class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates_presence_of :quantity, :price
  validates_inclusion_of :fulfilled, in: [true, false]

  def sub_total
    quantity * price
  end
end
