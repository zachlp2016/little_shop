class UsersController < ApplicationController


  def new
    @user = User.new

  end

  def create
    @user = User.new(strong_params)
    if password_confirmation != true
      render :new
      flash[:notice] = "Those passwords don't match"
    elsif @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You are now registered and logged in."
      redirect_to user_path(@user)
    else
      flash[:notice] = "That didn't work, please try again."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  private

  def password_confirmation
    if params["user"]["password"] == params["user"]["confirm_password"]
      true
    else
      false
    end
  end

  def strong_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

end
