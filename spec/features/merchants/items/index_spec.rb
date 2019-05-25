
require 'rails_helper'


RSpec.describe 'As a merchant' do
  describe 'When I visit my items page' do

    before :each do
      @merchant_1 = create(:user)
      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_1)
      @item_3 = create(:item, user: @merchant_1)
    end

    it 'I see a link to add item to the system' do
      visit dashboard_items_path

      expect(page).to have_link('Add a new item')
    end
  end
end


# I see each item I have already added to the system, including:
# - the ID of the item
# - the name of the item
# - a thumbnail image for that item
# - the price of that item
# - my current inventory count for that item
# - a link or button to edit the item
#
# If no user has ever ordered this item, I see a link to delete the item
# If the item is enabled, I see a button or link to disable the item
# If the item is disabled, I see a button or link to enable the item
