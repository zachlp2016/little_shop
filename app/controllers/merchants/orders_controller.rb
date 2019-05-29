class Merchants::OrdersController < Merchants::BaseController
  def show
    @merchant = current_user
    @order = Order.find(params[:id])
    @user = @order.user
    @order_items = @order.order_items.map {|order_item| order_item if order_item.item.user_id == @merchant.id}.compact
  end

  def index
    @user = User.find(current_user.id)
    @orders = @user.pending_orders
  end
end
