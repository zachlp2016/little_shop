class UsersController < ApplicationController

  def new
    @user = User.new

  end

  def create
    @user = User.new(strong_params)
    if password_validation != true
      render :new
      flash[:notice] = "Those passwords don't match"
    end
    if @user.save
      redirect_to '/profile'
    else
      render :new
    end
  end

  private

  def password_validation
    if params["user"]["password"] == params["user"]["confirm_password"]
      true
    else
      false
    end
  end

  def strong_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password_digest)
  end

end
