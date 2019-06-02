class Default::AddressesController < Default::BaseController

  def new
    @user = current_user
    @address = @user.addresses.new
  end

  def create
    @user = current_user
    @address = @user.addresses.create!(address_params)
    if @address.save
      flash[:notice] = "You have added a new address"
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit_home
    @user = current_user
  end

  def update_home
    @user = current_user
    @user.update(address_home_params)
    if @user.save
      flash[:notice] = "You have updated your home address."
      redirect_to profile_path
    else
      render :edit_home
    end
  end


  private

  def address_home_params
    params.require(:user).permit(:address_nickname, :address, :city, :state, :zip)
  end

  def address_params
    params.require(:address).permit(:nickname, :street, :city, :state, :zip)
  end
end
