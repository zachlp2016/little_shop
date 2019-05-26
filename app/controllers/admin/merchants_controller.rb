class Admin::MerchantsController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
    render template: "merchants/show"
  end
end