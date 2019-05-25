class OrdersController < ApplicationController
  def index
    @user = current_user
    @orders = @user.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end
end
