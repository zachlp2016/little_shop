class MerchantsController < ApplicationController

  def index
    @merchants = User.all_active_merchants if !current_admin?
    @merchants = User.where(role: :merchant) if current_admin?
    # require 'pry'; binding.pry
    @top_merchants = User.top_3_merchants_by_sales
    @fastest_merchants = User.fastest_3_fulfilling_merchants
    @slowest_merchants = User.slowest_3_fulfilling_merchants
    @top_3_states_by_order = User.top_3_states
    @top_3_cities_by_order = User.top_3_cities
    @biggest_orders = Order.biggest_3
  end

  def show
    @user = User.find(current_user.id)
    @orders = @user.pending_orders
  end

  def disable
    user = User.find_by(id: params[:id])
    if User.update(user.id, active: false)
      flash[:notice] = "Merchant's account is now disabled"
    end
    redirect_to merchants_path
  end

  def enable
    user = User.find_by(id: params[:id])
    if User.update(user.id, active: true)
      flash[:notice] = "Merchant's account is now enabled"
    end
    redirect_to merchants_path
  end
end
