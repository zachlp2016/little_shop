class Default::AddressesController < Default::BaseController

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

  def edit_non_home
    @user = current_user
    @address = current_user.addresses.find(params[:id])
  end

  def update_non_home
    @user = current_user
    @user.addresses.update(address_params)
    if @user.save!
      redirect_to profile_path
      flash[:notice] = "You have updated that address."
    else
      render :edit_non_home
    end
  end

  def erase_home
    @user = current_user
    @user.address = ""
    @user.city = ""
    @user.state = ""
    @user.zip = ""
    @user.save


    redirect_to profile_path
    flash[:notice] = "The home address has been deleted."
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
