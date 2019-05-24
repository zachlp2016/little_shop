class SessionsController < ApplicationController

  def new
    if !current_user.nil? && !current_merchant? && !current_admin?
      flash[:notice] = "You have already logged in."
      redirect_to profile_path
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in."
      redirects
    else
      flash[:notice] = "Those are the wrong credentials."
      render :new
    end
  end

  def logout
    reset_session
    flash.notice = "Succesfully Logged Out"
    redirect_to root_path
  end

  private



  def redirects
    if current_merchant?
      redirect_to dashboard_path
    elsif current_admin?
      redirect_to root_path
    else
      redirect_to profile_path
    end
  end
end
