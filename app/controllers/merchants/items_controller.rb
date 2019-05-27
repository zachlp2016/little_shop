class Merchants::ItemsController < ApplicationController

  def index
    @merchant = User.find(current_user.id)
  end

  def new
    @item = Item.new
  end

  def destroy
    @item = Item.destroy(params[:id])
    flash[:notice] = "Item #{@item.id} is now deleted."
    redirect_to dashboard_items_path
  end
end
