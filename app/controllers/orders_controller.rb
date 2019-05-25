class OrdersController < ApplicationController
  def index
    @user = current_user
    @orders = @user.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def destroy
    @order = Order.find(params[:id])
    @order.update(status: :cancelled)

    @order.order_items.each do |order_item|
      order_item.update(fulfilled: false)
    end

    flash[:notice] = "#{@order.id} has been cancelled."

    redirect_to profile_orders_path
  end
end
