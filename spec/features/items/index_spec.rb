require 'rails_helper'
# As any kind of user on the system
# I can visit the items catalog ("/items")
# I see all items in the system except disabled items
# Each item will display the following information:
# - the name of the item
# - a small thumbnail image for the item
# - the merchant name who sells the item
# - how many of the item the merchant has in stock
# - the merchant's current price for the item
#
# The item name is a link to that item's show page
# The item thumbnail is a link to that item's show page

RSpec.describe 'as a visitor' do
  describe 'when I visit the items catalog' do

    before :each do
      merchant_1 = create(:user)
      merchant_2 = create(:user)
      @item_1 = create(:item, user: merchant_1)
      @item_2 = create(:item, user: merchant_1)
      @item_3 = create(:item, user: merchant_1)
      @item_4 = create(:item, user: merchant_2)
      @item_5 = create(:item, user: merchant_2, active: false)
      @item_6 = create(:item, user: merchant_2, active: false)
    end

    it 'displays all enabled items info' do
      visit items_path

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

      within "#item-#{@item_4.id}" do
        expect(page).to have_content(@item_4.name)
        expect(page).to have_content(@item_4.user.name)
        expect(page).to have_content(@item_4.inventory)
        expect(page).to have_content(@item_4.price)
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      expect(page).to_not have_selector("#item-#{@item_5.id}")
      expect(page).to_not have_selector("#item-#{@item_6.id}")

    end

  end
end
