class AddressesController < ApplicationController

  def new
    @user = current_user
    @address = @user.addresses.new
  end

  def create
    @user = current_user
    @address = @user.addresses.new(address_params)
    if @address.save!
      flash[:notice] = "You have added a new address"
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @address = @user.addresses.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @user.addresses.update(address_params)
    if @user.save!
      redirect_to profile_path
      flash[:notice] = "You have updated that address."
    else
      render :edit
    end
  end

  def destroy
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
