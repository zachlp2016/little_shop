class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_merchant, :current_admin

  def current_user
    user = User.find(session[:user_id])
    if user.role == 0
      true
    end
  end

  def current_merchant
    user = User.find(session[:user_id])
    if user.role == 1
      true
    end
  end

  def current_admin
    user = User.find(session[:user_id])
    if user.role == 2
      true
    end
  end
end
