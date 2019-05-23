class UsersController < ApplicationController


  def new
    @user = User.new

  end

  def create
    @user = User.new(user_params)
    if password_confirmation != true
      flash.now[:notice] = "Those passwords don't match."
      render :new
    elsif email_confirmation == true
      flash.now[:notice] = "That email address is already taken."
      render :new
    elsif @user.save!
      session[:user_id] = @user.id
      flash[:notice] = "You are now registered and logged in."
      redirect_to profile_path
    else
      flash.now[:notice] = "That didn't work, please try again."
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if password_confirmation != true
      flash.now[:notice] = "Those passwords don't match."
      render :edit
    elsif email_confirmation(@user.email) == true
      flash.now[:notice] = "That email address is already taken."
      render :edit
    elsif @user.update!(user_params)
      flash[:notice] = "Your information has been updated!"
      redirect_to profile_path
    else
      flash.now[:notice] = "That didn't work, please try again."
      render :edit
    end
  end

  private

  def email_confirmation(user_email = nil)
    (User.email_string - [user_email]).include?(params[:user][:email])
  end

  def password_confirmation
    if params["user"]["password"] == params["user"]["confirm_password"]
      true
    else
      false
    end
  end

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end

end
