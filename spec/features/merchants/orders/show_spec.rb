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

    it 'Displays only my Items in the Order' do
      visit dashboard_order_path(@order)

      within("#item-#{@item_1.id}") do
        expect(page).to have_button(@item_1.name, href: item_path(@item_1))
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(@order_item_1.quantity)
      end

      within("#item-#{@item_2.id}") do
        expect(page).to have_button(@item_2.name, href: item_path(@item_1))
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content(@order_item_2.quantity)
      end

      expect(page).to_not have_css("#item-#{@item_3.id}")
    end
  end
end
