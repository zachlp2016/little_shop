class Merchants::ItemsController < ApplicationController

  def index
    @merchant = User.find(current_user.id)
  end


  def disable
    @item = Item.find(params[:id])
    @item.active = false
    @item.save
    flash[:notice] = "This item has been disabled."
    redirect_to dashboard_items_path
  end

  def destroy
    @item = Item.destroy(params[:id])
    flash[:notice] = "Item #{@item.id} is now deleted."
    redirect_to dashboard_items_path
  end

  def enable
    @item = Item.find(params[:id])
    @item.active = true
    @item.save
    flash[:notice] = "This item has been enabled."
    redirect_to dashboard_items_path
  end
end
