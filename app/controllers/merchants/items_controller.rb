class Merchants::ItemsController < ApplicationController

  def index
    @merchant = User.find(current_user.id)
  end

  def new
    @merchant = User.find(current_user.id)
    @item = @merchant.items.new
  end



  def create
    if verify_price(params) == false
      flash[:notice] = "The price for that item cannot be negative."
      redirect_to dashboard_items_path
    elsif verify_inventory_count(params) == false
      flash[:notice] = "The inventory for that item cannot be a negative number."
      redirect_to dashboard_items_path
    else
      verify_image(params)
      @merchant = User.find(current_user.id)
      @item = @merchant.items.create!(items_params)
      if @item.save
        flash[:notice] = "The item was created successfully."
        redirect_to dashboard_items_path
      else
        render :new
      end
    end
  end

  def edit
    @merchant = current_user
    @item = @merchant.items.find(params[:id])
  end

  def update
    binding.pry
    @merchant = current_user
    @item = @merchant.items.find(params[:id])
  end

  def disable
    @item = Item.find(params[:id])
    @item.active = false
    @item.save
    flash[:notice] = "This item has been disabled."
    redirect_to dashboard_items_path
  end

  def enable
    @item = Item.find(params[:id])
    @item.active = true
    @item.save
    flash[:notice] = "This item has been enabled."
    redirect_to dashboard_items_path
  end

  def destroy
    @item = Item.destroy(params[:id])
    flash[:notice] = "Item #{@item.id} is now deleted."
    redirect_to dashboard_items_path
  end

  private

  def items_params
    params.require(:item).permit(:name, :price, :description, :image, :inventory )
  end

  def verify_price(params)
    if params["item"]["price"].to_i < 0
      return false
    end
  end

  def verify_inventory_count(params)
    if params["item"]["inventory"].to_i < 0
      return false
    end
  end

  def verify_image(params)
    if params["item"]["image"] == ""
      params["item"]["image"] = "https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg"
    end
  end

end
