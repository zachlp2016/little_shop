class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates_presence_of :quantity, :price
  validates_inclusion_of :fulfilled, in: [true, false]

  after_save :update_inventory, :check_order, unless: :just_created?

  def sub_total
    quantity * price
  end

  private

  def update_inventory
    if saved_change_to_fulfilled?

      if fulfilled
        new_inventory = item.inventory - quantity
        item.update(inventory: new_inventory)
      else
        new_inventory = item.inventory + quantity
        item.update(inventory: new_inventory)
      end
    end
  end

  def check_order
    if saved_change_to_fulfilled?
      if fulfilled
        order.check_fulfillments
      end
    end
  end

  def just_created?
    created_at == updated_at
  end
end
