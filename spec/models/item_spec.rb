require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :orders }
  end

  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :price}
    it { should validate_presence_of :description}
    it { should validate_presence_of :image}
    it { should validate_presence_of :inventory}
  end

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

  describe 'class methods' do

    it '.all_active' do
      active = [@item_1, @item_2, @item_3, @item_4]
      non_active = [@item_5, @item_6]

      Item.all_active.each do |item|
        expect(active.include?(item)).to be true
        expect(non_active.include?(item)).to be false
      end

    end

    it '.most_5_bought' do
      expect(Item.most_5_bought[0]).to eq(@item_2)
      expect(Item.most_5_bought[1]).to eq(@item_1)
      expect(Item.most_5_bought[2]).to eq(@item_5)
      expect(Item.most_5_bought[3]).to eq(@item_4)
      expect(Item.most_5_bought[4]).to eq(@item_3)
      expect(Item.most_5_bought.length).to eq(5)
    end

    it '.least_5_bought' do
      expect(Item.least_5_bought[0]).to eq(@item_6)
      expect(Item.least_5_bought[1]).to eq(@item_3)
      expect(Item.least_5_bought[2]).to eq(@item_4)
      expect(Item.least_5_bought[3]).to eq(@item_5)
      expect(Item.least_5_bought[4]).to eq(@item_1)
      expect(Item.least_5_bought.length).to eq(5)
    end

  end

end
