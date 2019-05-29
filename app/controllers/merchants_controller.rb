class MerchantsController < ApplicationController

  def index
    @merchants = User.all_active_merchants if !current_admin?
    @merchants = User.where(role: :merchant) if current_admin?
    @top_merchants = User.top_3_merchants_by_sales
    @fastest_merchants = User.fastest_3_fulfilling_merchants
    @slowest_merchants = User.slowest_3_fulfilling_merchants
    @top_3_states_by_order = User.top_3_states
    @top_3_cities_by_order = User.top_3_cities
    @biggest_orders = Order.biggest_3
  end
end
