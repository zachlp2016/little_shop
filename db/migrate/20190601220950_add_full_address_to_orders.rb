class AddFullAddressToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :full_address, :string
  end
end
