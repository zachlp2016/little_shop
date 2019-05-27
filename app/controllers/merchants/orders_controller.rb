class Merchants::OrdersController <ApplicationController
  def show
    @merchant = current_user
    @order = Order.find(params[:id])
    @user = @order.user
    @order_items = @order.order_items.map {|order_item| order_item if order_item.item.user_id == @merchant.id}.compact
  end
end
