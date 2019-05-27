class MerchantsController < ApplicationController

  def index
    @merchants = User.all_active_merchants
    @top_merchants = User.top_3_merchants_by_sales
    @fastest_merchants = User.fastest_3_fulfilling_merchants
    @slowest_merchants = User.slowest_3_fulfilling_merchants
  end

  def show
    @user = User.find(current_user.id)
  end

end
