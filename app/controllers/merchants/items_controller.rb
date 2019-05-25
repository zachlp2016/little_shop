class Merchants::ItemsController < ApplicationController

  def index
    @merchant = User.find(current_user.id)
    binding.pry
  end

end
