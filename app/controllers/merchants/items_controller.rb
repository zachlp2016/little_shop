class Merchants::ItemsController < ApplicationController

  def index
    @merchant = User.find(current_user.id)
  end

  def disable

  end
end
