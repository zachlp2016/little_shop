class Merchants::ItemsController < ApplicationController

  def index
    @merchant = User.find(current_user.id)
  end

  def new
    @merchant = User.find(current_user.id)
    @item = @merchant.items.new
  end

  def create
    verify_image(params)
    binding.pry
    @merchant = User.find(current_user.id)
    @item = @merchant.items.create!(items_params)
    if @item.save
      flash[:notice] = "The item was created successfully."
      redirect_to dashboard_items_path
    else
      render :new
    end
  end

  def destroy
    @item = Item.destroy(params[:id])
    flash[:notice] = "Item #{@item.id} is now deleted."
    redirect_to dashboard_items_path
  end

  private

  def items_params
    params.require(:item).permit(:name, :price, :description, :inventory )
  end

  def verify_image(params)
    if params["item"]["image"] == ""
      params["item"]["image"] = "https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg"
    end
  end
end
