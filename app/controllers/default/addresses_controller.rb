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

  private

  def address_params
    params.require(:address).permit(:nickname, :street, :city, :state, :zip)
  end
end
