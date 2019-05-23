require 'rails_helper'

RSpec.describe 'As a Registered User', type: :feature do
  include ActiveSupport::Testing::TimeHelpers

  describe 'When I visit my own Orders page' do
    before :each do
      @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 1, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")
      @merchant_1 = create(:user)
      @merchant_2 = create(:user)
      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_1)
      @item_3 = create(:item, user: @merchant_1)
      @item_4 = create(:item, user: @merchant_2)
      @item_5 = create(:item, user: @merchant_2)
      @item_6 = create(:item, user: @merchant_2)
      @order_1 = create(:order, user: @user)
      travel_to Time.zone.local(2019, 05, 10, 18, 00, 00)
      @order_2 = create(:order, user: @user)
      travel_to Time.zone.local(2019, 05, 02, 12, 00, 00)
      @order_3 = create(:order, user: @user)
      travel_to Time.zone.local(2018, 01, 15, 14, 00, 00)
      @order_4 = create(:order, user: @user)
      travel_back
      order_item_1 = create(:order_item, order: @order_1, item: @item_1)
      order_item_2 = create(:order_item, order: @order_1, item: @item_2)
      order_item_3 = create(:order_item, order: @order_2, item: @item_2)
      order_item_4 = create(:order_item, order: @order_2, item: @item_3)
      order_item_5 = create(:order_item, order: @order_2, item: @item_5)
      order_item_6 = create(:order_item, order: @order_3, item: @item_1)
      order_item_7 = create(:order_item, order: @order_3, item: @item_6)
      order_item_8 = create(:order_item, order: @order_4, item: @item_5)
      order_item_9 = create(:order_item, order: @order_4, item: @item_2)
      order_item_10 = create(:order_item, order: @order_4, item: @item_3)
      order_item_11 = create(:order_item, order: @order_4, item: @item_1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'I see all my orders' do
      visit profile_orders_path

      expect(page).to have_content("#{@user.name}'s Orders")

      expect(page).to have_css("#order-#{@order_1.id}")
      expect(page).to have_css("#order-#{@order_2.id}")
      expect(page).to have_css("#order-#{@order_3.id}")
      expect(page).to have_css("#order-#{@order_4.id}")
    end

    it 'I see all information for each order' do
      visit profile_orders_path

      within("#order-#{@order_1.id}") do
        expect(page).to have_link("Order ID: #{@order_1.id}")
        expect(page).to have_content("Date Made: #{@order_1.date_made}")
        expect(page).to have_content("Last Updated: #{@order_1.last_updated}")
        expect(page).to have_content("Current Status: #{@order_1.status}")
        expect(page).to have_content("Number of Items: #{@order_1.item_count}")
        expect(page).to have_content("Grand Total: #{@order_1.grand_total}")
      end

      within("#order-#{@order_2.id}") do
        expect(page).to have_link("Order ID: #{@order_2.id}")
        expect(page).to have_content("Date Made: #{@order_2.date_made}")
        expect(page).to have_content("Last Updated: #{@order_2.last_updated}")
        expect(page).to have_content("Current Status: #{@order_2.status}")
        expect(page).to have_content("Number of Items: #{@order_2.item_count}")
        expect(page).to have_content("Grand Total: #{@order_2.grand_total}")
      end

      within("#order-#{@order_3.id}") do
        expect(page).to have_link("Order ID: #{@order_3.id}")
        expect(page).to have_content("Date Made: #{@order_3.date_made}")
        expect(page).to have_content("Last Updated: #{@order_3.last_updated}")
        expect(page).to have_content("Current Status: #{@order_3.status}")
        expect(page).to have_content("Number of Items: #{@order_3.item_count}")
        expect(page).to have_content("Grand Total: #{@order_3.grand_total}")
      end

      within("#order-#{@order_4.id}") do
        expect(page).to have_link("Order ID: #{@order_4.id}")
        expect(page).to have_content("Date Made: #{@order_4.date_made}")
        expect(page).to have_content("Last Updated: #{@order_4.last_updated}")
        expect(page).to have_content("Current Status: #{@order_4.status}")
        expect(page).to have_content("Number of Items: #{@order_4.item_count}")
        expect(page).to have_content("Grand Total: #{@order_4.grand_total}")
      end
    end

    it 'I see no items if I have no orders' do
      user = User.create!(email: "not_test@test.com", password_digest: "t3s7", role: 1, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit profile_orders_path

      expect(page).to have_content("#{user.name}'s Orders")

      expect(page).to_not have_css("#order-\d")

      expect(page).to have_content("You haven't made any orders yet!")
    end
  end
end
