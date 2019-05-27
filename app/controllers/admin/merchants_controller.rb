class Admin::MerchantsController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])

    if @user.role == "default"
      redirect_to admin_user_path(@user.id)
    else
      @orders = @user.pending_orders

      render template: "merchants/show"
    end
  end

  def edit
    user = User.find_by(id: params[:id])
    request = params[:request]
    if request == 'upgrade_to_merchant'
      User.update(user.id, role: :merchant)
      flash[:notice] = "User #{user.name} has been promoted to Merchant"
      redirect_to "/admin/merchants/#{user.id}"
    elsif request == 'downgrade_to_user'
      User.update(user.id, role: :default)
      flash[:notice] = "User #{user.name} has been demoted to Default"
      redirect_to admin_user_path(user.id)
    end
  end
end