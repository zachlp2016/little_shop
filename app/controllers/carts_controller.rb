class CartsController < ApplicationController
  def show
    @user = current_user
    cart = Cart.new(session[:cart])
    @cart_items = cart.ids_to_items
    @cart_price_total = cart.total_price
  end

  def add
    item = Item.find(params[:item_id])
    cart = Cart.new(session[:cart])
    cart.add(item.id)
    session[:cart] = cart.contents
    flash.notice = "#{item.name} has been added to your cart"
    redirect_to items_path
  end

  def clear
    session[:cart] = {}
    redirect_to carts_path
  end
end
