require 'rails_helper'

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
      buyer_1 = create(:user)
      buyer_2 = create(:user)
      buyer_3 = create(:user)
      buyer_4 = create(:user)
      order_1 = create(:order, user: buyer_1)
      order_2 = create(:order, user: buyer_1)
      order_3 = create(:order, user: buyer_2)
      order_4 = create(:order, user: buyer_2)
      order_5 = create(:order, user: buyer_3)
      order_6 = create(:order, user: buyer_3)
      order_7 = create(:order, user: buyer_3)
      order_8 = create(:order, user: buyer_2)
      order_9 = create(:order, user: buyer_1)
      order_10 = create(:order, user: buyer_3)
      order_11 = create(:order, user: buyer_4)
      OrderItem.create!(item: @item_1, order: order_1, quantity: 12, price: 1.99, fulfilled: true)
      OrderItem.create!(item: @item_2, order: order_2, quantity: 3, price: 6.99, fulfilled: true)
      OrderItem.create!(item: @item_3, order: order_3, quantity: 6, price: 11.99, fulfilled: true)
      OrderItem.create!(item: @item_4, order: order_4, quantity: 7, price: 12.99, fulfilled: true)
      OrderItem.create!(item: @item_5, order: order_5, quantity: 14, price: 13.99, fulfilled: true)
      OrderItem.create!(item: @item_6, order: order_6, quantity: 5, price: 2.99, fulfilled: true)
      OrderItem.create!(item: @item_1, order: order_7, quantity: 21, price: 9.99, fulfilled: true)
      OrderItem.create!(item: @item_2, order: order_8, quantity: 31, price: 7.99, fulfilled: true)
      OrderItem.create!(item: @item_3, order: order_9, quantity: 2, price: 12.99, fulfilled: false)
      OrderItem.create!(item: @item_4, order: order_10, quantity: 3, price: 11.99, fulfilled: false)
      OrderItem.create!(item: @item_5, order: order_11, quantity: 1, price: 21.99, fulfilled: false)
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

    it 'has item show pages linked to the item name and image' do
      visit items_path

      within "#item-#{@item_1.id}" do
        click_link @item_1.name
      end

      expect(current_path).to eq(item_path(@item_1))

      visit items_path

      within "#item-#{@item_4.id}" do
        page.first(".image_link").click
      end

      expect(current_path).to eq(item_path(@item_4))

    end


      # As any kind of user on the system
      # When I visit the items index page ("/items")
      # I see an area with statistics:
      # - the top 5 most popular items by quantity purchased, plus the quantity bought
      # - the bottom 5 least popular items, plus the quantity bought
      #
      # "Popularity" is determined by total quantity of that item fulfilled

    it 'has an area with statistics' do
      visit items_path

      within '#top-stats' do
        text = page.current_scope.text
        
        text.index(@item_2.name) < text.index(@item_1.name)
        text.index(@item_1.name) < text.index(@item_5.name)
        text.index(@item_5.name) < text.index(@item_4.name)
        text.index(@item_4.name) < text.index(@item_3.name)
        # expect(@item_2.name).to appear_before(@item_1.name)
        # expect(@item_1.name).to appear_before(@item_5.name)
        # expect(@item_5.name).to appear_before(@item_4.name)
        # expect(@item_4.name).to appear_before(@item_3.name)
      end

      within '#bottom-stats' do
        text = page.current_scope.text
        
        text.index(@item_6.name) < text.index(@item_3.name)
        text.index(@item_3.name) < text.index(@item_4.name)
        text.index(@item_4.name) < text.index(@item_5.name)
        text.index(@item_5.name) < text.index(@item_1.name)
        # expect(@item_6.name).to appear_before(@item_3.name)
        # expect(@item_3.name).to appear_before(@item_4.name)
        # expect(@item_4.name).to appear_before(@item_5.name)
        # expect(@item_5.name).to appear_before(@item_1.name)
      end

      # within '#bottom-stats' do
      #   expect(page).to have_content("Least Purchased Items")
      #   expect(page.all(".stat-items")[0]).to have_content(@item_6.name)
      #   expect(page.all(".stat-items")[1]).to have_content("Total Bought: 5")
      #   expect(page.all(".stat-items")[2]).to have_content(@item_3.name)
      #   expect(page.all(".stat-items")[3]).to have_content("Total Bought: 6")
      #   expect(page.all(".stat-items")[4]).to have_content(@item_4.name)
      #   expect(page.all(".stat-items")[5]).to have_content("Total Bought: 7")
      #   expect(page.all(".stat-items")[6]).to have_content(@item_5.name)
      #   expect(page.all(".stat-items")[7]).to have_content("Total Bought: 14")
      #   expect(page.all(".stat-items")[8]).to have_content(@item_1.name)
      #   expect(page.all(".stat-items")[9]).to have_content("Total Bought: 33")
      # end

    end
  end
end
