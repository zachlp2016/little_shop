
require 'rails_helper'


RSpec.describe 'As a merchant' do
  describe 'When I visit my items page' do

    before :each do
      @merchant_1 = create(:user)
      @merchant_2 = create(:user)
      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_1)
      @item_3 = create(:item, user: @merchant_1)
      @item_4 = create(:item, user: @merchant_2)
      @item_5 = create(:item, user: @merchant_2)
    end

    it 'I see a link to add item to the system' do
      visit dashboard_items_path

      expect(page).to have_link('Add a new item')

      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.user.name)
        expect(page).to have_content(@item_1.inventory)
        expect(page).to have_content(@item_1.price)
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.user.name)
        expect(page).to have_content(@item_2.inventory)
        expect(page).to have_content(@item_2.price)
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      within "#item-#{@item_3.id}" do
        expect(page).to have_content(@item_3.name)
        expect(page).to have_content(@item_3.user.name)
        expect(page).to have_content(@item_3.inventory)
        expect(page).to have_content(@item_3.price)
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      expect(page).to_not have_content(@item_4.name)
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
