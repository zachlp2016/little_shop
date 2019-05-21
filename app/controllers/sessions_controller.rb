class SessionsController < ApplicationController

  def new


  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in."
      redirects
    else
      render :new
    end
  end


  private



  def redirects
    if current_user
      redirect_to user_path(session[:user_id])
    elsif current_merchant
      redirect_to dashboard_path
    else current_admin
      redirect_to root_path
    end
  end
end
