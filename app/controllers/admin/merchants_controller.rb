class Admin::MerchantsController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
    @orders = @user.pending_orders
    
    render template: "merchants/show"
  end
end