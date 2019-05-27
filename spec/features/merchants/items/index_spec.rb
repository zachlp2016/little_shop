
require 'rails_helper'


RSpec.describe 'As a merchant' do
  describe 'When I visit my items page' do

    before :each do
      @merchant_1 = create(:user, role: 1)
      @merchant_2 = create(:user, role: 1)
      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_1)
      @item_3 = create(:item, user: @merchant_1)
      @item_4 = create(:item, user: @merchant_2)
      @item_5 = create(:item, user: @merchant_2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
    end

    it 'I see a list of the items that I have' do
      visit dashboard_items_path

      expect(page).to have_link('Add a new item')

      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.id)
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.inventory)
        expect(page).to have_content(@item_1.price)
        expect(page).to have_link('Edit this item')
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.id)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.inventory)
        expect(page).to have_content(@item_2.price)
        expect(page).to have_link('Edit this item')
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      within "#item-#{@item_3.id}" do
        expect(page).to have_content(@item_3.id)
        expect(page).to have_content(@item_3.name)
        expect(page).to have_content(@item_3.inventory)
        expect(page).to have_content(@item_3.price)
        expect(page).to have_link('Edit this item')
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      expect(page).to_not have_content(@item_4.name)
      expect(page).to_not have_content(@item_5.name)
    end
  end

  describe 'When I visit my items page, delete item only shows if a buyer isnt found' do

    before :each do
      @merchant_1 = create(:user, role: 1)
      @merchant_2 = create(:user, role: 1)
      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_1)
      @item_3 = create(:item, user: @merchant_1, active: false)
      @item_4 = create(:item, user: @merchant_2)
      @item_5 = create(:item, user: @merchant_2)
      @user = create(:user)
      order_1 = create(:order, user: @user)
      OrderItem.create!(item: @item_2, order: order_1, quantity: 12, price: 1.99, fulfilled: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
    end

    it 'has a link to delete the item if no user has ordered this item' do
      # If no user has ever ordered this item, I see a link to delete the item
      visit dashboard_items_path

      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.id)
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.inventory)
        expect(page).to have_content(@item_1.price)
        expect(page).to have_link('Edit this item')

        expect(page).to have_link('Delete this item')
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.id)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.inventory)
        expect(page).to have_content(@item_2.price)
        expect(page).to have_link('Edit this item')

        expect(page).to_not have_link('Delete this item')
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end
    end

    it 'has a link to enable if the item is disabled' do
      visit dashboard_items_path
      within "#item-#{@item_1.id}" do


        expect(page).to_not have_link('Enable this item')
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      within "#item-#{@item_3.id}" do

        expect(page).to have_link('Enable this item')
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end
    end

    it 'has a link to disable if the item is enabled' do
      visit dashboard_items_path
      within "#item-#{@item_1.id}" do

        expect(page).to have_link('Disable this item')
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      within "#item-#{@item_3.id}" do

        expect(page).to_not have_link('Disable this item')
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end
    end

    it 'can delete an item' do
      visit dashboard_items_path

      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.id)
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.inventory)
        expect(page).to have_content(@item_1.price)

        expect(page).to have_link('Delete this item')
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"

        click_link('Delete this item')
      end

      expect(page).to have_content("Item #{@item_1.id} is now deleted.")
      expect(page).to_not have_content("Item id: #{@item_1.id}")
    end

    it 'can add an item' do
      visit dashboard_items_path

      click_link('Add a new item')

      expect(current_path).to eq('/dashboard/items/new')

      fill_in 'Name', with: 'Velveeta'
      fill_in 'Description', with: 'Glorified Cheese Wizz.'
      fill_in 'Image', with: 'https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg'
      fill_in 'Price', with: '3.90'
      fill_in 'Inventory', with: '25'


      click_button 'Create Item'


      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_content('The item was created successfully.')

      @lastitem = Item.last

      within "#item-#{@lastitem.id}" do
        expect(page).to have_content(@lastitem.id)
        expect(page).to have_content(@lastitem.name)
        expect(page).to have_content(@lastitem.inventory)
        expect(page).to have_content(@lastitem.price)

        expect(page).to have_link('Disable this item')
        expect(page).to have_link('Delete this item')
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end
    end
  end
end

# I see a form where I can add new information about an item, including:
# - the name of the item, which cannot be blank
# - a description for the item, which cannot be blank
# - a thumbnail image URL string, which CAN be left blank
# - a price which must be greater than $0.00
# - my current inventory count of this item which is 0 or greater
#
# When I submit valid information and save the form
# I am taken back to my items page
# I see a flash message indicating my new item is saved
# I see the new item on the page, and it is enabled and available for sale
# If I left the image field blank, I see a placeholder image for the thumbnail
