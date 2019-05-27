class Merchants::ItemsController < ApplicationController

  def index
    @merchant = User.find(current_user.id)
  end

  def new
    @merchant = User.find(current_user.id)
    @item = @merchant.items.new
  end

  def create
    @item = Item.create!(params)

  end

  def destroy
    @item = Item.destroy(params[:id])
    flash[:notice] = "Item #{@item.id} is now deleted."
    redirect_to dashboard_items_path
  end

  private

  def user_params
    params.require(:item).permit(:name, :price, :description, :image, :inventory )
  end
end
