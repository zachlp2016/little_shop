class Default::UsersController < Default::BaseController
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
      flash[:notice] = "Email has already been taken"
      render :edit
    elsif @user.update(user_params)
      flash[:notice] = "Your information has been updated!"
      redirect_to profile_path
    else
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
