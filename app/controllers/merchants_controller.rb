class MerchantsController < ApplicationController

  def index
    @merchants = User.all_active_merchants if !current_admin?
    @merchants = User.where(role: :merchant) if current_admin?
  end

  def show
    @user = User.find(current_user.id)
  end
end
