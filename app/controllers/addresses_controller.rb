class AddressesController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @address = @user.addresses.new
  end

  def create
    @user = User.find(params[:user_id])
    @address = @user.addresses.new(address_params)
    if @address.save
      flash[:notice] = "You have added a new address"
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @address = Address.find(params[:id])
    order_detection(@user, @address)
  end

  def order_detection(user, address)
    user.orders.each do |order|
      if order.status == "shipped" || order.status == "packaged"
        redirect_to profile_path
        flash["notice"] = "You cannot update or delete an address if its already being used in an order."
      end
    end
  end

  def update
    @user = User.find(params[:user_id])
    address = Address.update(params[:id], address_params)
    if address.save
      redirect_to profile_path
      flash[:notice] = "You have updated your address."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @address = Address.find(params[:id])
    order_detection(@user, @address)
    Address.destroy(params[:id])
    flash[:notice] = "The address has been deleted."
    redirect_to profile_path
  end


  private

  def address_params
    params.require(:address).permit(:nickname, :street, :city, :state, :zip)
  end

  def address_home_params
    params.require(:user).permit(:address_nickname, :address, :city, :state, :zip)
  end

end
