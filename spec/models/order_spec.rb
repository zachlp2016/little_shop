require 'rails_helper'

RSpec.describe Order, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :items}
  end

  describe 'validations' do
    it { should validate_presence_of :status }
  end

  describe 'instance methods' do
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
      travel_to Time.zone.local(2019, 04, 11, 8, 00, 00)
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
    end

    it '#date_made' do
      expect(@order_1.date_made).to eq("April 11, 2019")
      expect(@order_2.date_made).to eq("May 10, 2019")
      expect(@order_3.date_made).to eq("May 2, 2019")
      expect(@order_4.date_made).to eq("January 15, 2018")
    end

    it 'last_updated' do
      travel_to Time.zone.local(2019, 04, 12, 8, 00, 00)
      @order_1.update(status: 2)
      travel_to Time.zone.local(2019, 05, 11, 18, 00, 00)
      @order_2.update(status: 2)
      travel_to Time.zone.local(2019, 05, 03, 12, 00, 00)
      @order_3.update(status: 2)
      travel_to Time.zone.local(2018, 01, 16, 14, 00, 00)
      @order_4.update(status: 2)

      expect(@order_1.last_updated).to eq("April 12, 2019")
      expect(@order_2.last_updated).to eq("May 11, 2019")
      expect(@order_3.last_updated).to eq("May 3, 2019")
      expect(@order_4.last_updated).to eq("January 16, 2018")
    end

    it '#item_count' do
      expect(@order_1.item_count).to eq(2)
      expect(@order_2.item_count).to eq(3)
      expect(@order_3.item_count).to eq(2)
      expect(@order_4.item_count).to eq(4)
    end

    it '#grand_total' do
      expect(@order_1.grand_total).to eq(19.98)
      expect(@order_2.grand_total).to eq(29.97)
      expect(@order_3.grand_total).to eq(19.98)
      expect(@order_4.grand_total).to eq(39.96)
    end

  end
end
