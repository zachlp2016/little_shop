class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  validates_presence_of :status

  enum status: ["Pending", "Packaged", "Shipped", "Cancelled"]

  def date_made
    created_at.strftime("%B %-d, %Y")
  end

  def last_updated
    updated_at.strftime("%B %-d, %Y")
  end

  def item_count
    items.count
  end

  def grand_total
    order_items.sum do |item|
      item.price * item.quantity
    end
  end
end
