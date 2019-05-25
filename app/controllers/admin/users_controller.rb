class Admin::UsersController < ApplicationController
  def index
    @default_users = User.where(role: :default)
  end

  def show
    @user = User.find_by(id: params[:id])
  end
end