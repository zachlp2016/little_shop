class Merchants::OrderItemsController < Merchants::BaseController
  def update
    order_item = OrderItem.find(params[:id])
    order = Order.find(order_item.order_id)

    order_item.update(fulfilled: true)
    flash[:notice] = "Item '#{order_item.item.name}' fulfilled."

    redirect_to dashboard_order_path(order)
  end
end
