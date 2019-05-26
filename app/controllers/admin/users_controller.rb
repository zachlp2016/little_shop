class Admin::UsersController < ApplicationController
  def index
    @default_users = User.where(role: :default)
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def dashboard
    @user = current_user
    @orders = Order.order(:status)
  end
end