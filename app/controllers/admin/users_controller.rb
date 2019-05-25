class Admin::UsersController < ApplicationController
  def index
    @default_users = User.where(role: :default)
  end
end