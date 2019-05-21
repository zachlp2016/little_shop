class SessionsController < ApplicationController

  def new


  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in."
      redirect_to '/profile'
    else
      render :new
    end
  end
end
