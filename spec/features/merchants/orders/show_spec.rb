require 'rails_helper'

RSpec.describe 'As a merchant', type: :feature do
  describe 'When I visit an order show page from my Dasboard' do
    before :each do
      @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 1, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

      @merchant_1 = create(:user, role: 1)
      @merchant_2 = create(:user, role: 1)

      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_1)
      @item_3 = create(:item, user: @merchant_2)

      @order = create(:order, user: @user)

      @order_item_1 = create(:order_item, order: @order, item: @item_1)
      @order_item_2 = create(:order_item, order: @order, item: @item_2)
      @order_item_3 = create(:order_item, order: @order, item: @item_3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
    end

    it 'Displays the Orders User information' do
      visit dashboard_order_path(@order)

      expect(page).to have_content("Name: Testy McTesterson")
      expect(page).to have_content("Address: 123 Test St, Testville, Test, 01234")
    end
  end
end
