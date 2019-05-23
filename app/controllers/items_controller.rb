class ItemsController < ApplicationController

  def index
    @items = Item.all_active
    @most_5_bought_items = Item.most_5_bought
    @least_5_bought_items = Item.least_5_bought
  end

  def show
    @item = Item.find_by(id: params['id'])
  end
end