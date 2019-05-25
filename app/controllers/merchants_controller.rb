class MerchantsController < ApplicationController

  def index
    @merchants = User.all_active_merchants
  end

  def show
    @user = User.find(current_user.id)
    @orders = @user.pending_orders
  end
end
