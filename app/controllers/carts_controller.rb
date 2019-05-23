class CartsController < ApplicationController
  def index
  end

  def create
    item = Item.find(params[:item_id])
    cart = Cart.new(session[:cart])
    cart.add(item.id)
    session[:cart] = cart.contents
    flash.notice = "#{item.name} has been added to your cart"
    redirect_to items_path
  end
end
