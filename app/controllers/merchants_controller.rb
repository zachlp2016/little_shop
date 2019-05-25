class MerchantsController < ApplicationController

  def index
    @merchants = User.all_active_merchants if !current_admin?
    @merchants = User.where(role: :merchant) if current_admin?
  end

  def show
    @user = User.find(current_user.id)
  end

  def disable
    user = User.find_by(id: params[:id])
    if User.update(user.id, active: false)
      flash[:notice] = "Merchant's account is now disabled"
    else
      flash[:notice] = "Error on updating"
    end
    redirect_to merchants_path
  end

  def enable
    user = User.find_by(id: params[:id])
    if User.update(user.id, active: true)
      flash[:notice] = "Merchant's account is now enabled"
    else
      flash[:notice] = "Error on updating"
    end
    redirect_to merchants_path
  end
end

