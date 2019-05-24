require 'rails_helper'

RSpec.describe 'As a Registered User', type: :feature do
  include ActiveSupport::Testing::TimeHelpers

  describe 'When I visit of my Orders show pages' do
    before :each do
      @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 1, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

      @merchant_1 = create(:user)
      @merchant_2 = create(:user)

      @item_1 = create(:item, user: @merchant_1)
      @item_2 = create(:item, user: @merchant_1)
      @item_3 = create(:item, user: @merchant_2)

      travel_to Time.zone.local(2019, 04, 11, 8, 00, 00)
      @order_1 = create(:order, user: @user)
      travel_to Time.zone.local(2019, 04, 12, 8, 00, 00)
      @order_1.update(status: 2)
      travel_back

      @order_item_1 = create(:order_item, order: @order_1, item: @item_1)
      @order_item_2 = create(:order_item, order: @order_1, item: @item_2)
      @order_item_3 = create(:order_item, order: @order_1, item: @item_3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'Has all the information for the Order' do
      visit profile_order_path(@order_1)

      expect(page).to have_content("Date Made: #{@order_1.date_made}")
      expect(page).to have_content("Last Updated: #{@order_1.last_updated}")
      expect(page).to have_content("Current Status: #{@order_1.status.capitalize}")

      within("#order-item-#{@item_1}") do
        expect(page).to have_content("#{@item_1.name}")
        expect(page).to have_content("#{@item_1.description}")
        expect(page).to have_content("#{@item_1.image}")
        expect(page).to have_content("Quantity: #{@order_item_1.quantity}")
        expect(page).to have_content("Subtotal: #{@order_item_1.sub_total}")
      end

      within("#order-item-#{@item_2}") do
        expect(page).to have_content("#{@item_2.name}")
        expect(page).to have_content("#{@item_2.description}")
        expect(page).to have_content("#{@item_2.image}")
        expect(page).to have_content("Quantity: #{@order_item_2.quantity}")
        expect(page).to have_content("Subtotal: #{@order_item_2.sub_total}")
      end

      within("#order-item-#{@item_3}") do
        expect(page).to have_content("#{@item_3.name}")
        expect(page).to have_content("#{@item_3.description}")
        expect(page).to have_content("#{@item_3.image}")
        expect(page).to have_content("Quantity: #{@order_item_3.quantity}")
        expect(page).to have_content("Subtotal: #{@order_item_3.sub_total}")
      end

      expect(page).to have_content("Number of Items: #{@order_1.item_count}")
      expect(page).to have_content("Grand Total: #{@order_1.grand_total}")
    end
  end
end
