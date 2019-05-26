require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :orders }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password_digest }
    # it { should validate_presence_of :role }
    # it { should validate_presence_of :active }
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }

    it { should validate_uniqueness_of :email }
  end

  describe 'class methods' do

    it 'email_string' do
      user_1 = User.create!(name: "default_user", role: 0, active: true, password_digest: "8320280282", address: "333", city: "Denver", state: "CO", zip: "80000", email: "default_user@gmail.com" )
      user_2 = User.create!(name: "default_user1", role: 0, active: true, password_digest: "8320280282", address: "333", city: "Denver", state: "CO", zip: "80000", email: "default_user1@gmail.com" )
      user_3 = User.create!(name: "default_user2", role: 0, active: true, password_digest: "8320280282", address: "333", city: "Denver", state: "CO", zip: "80000", email: "default_user2@gmail.com" )

      expect(User.email_string).to include("default_user@gmail.com")
      expect(User.email_string).to include("default_user1@gmail.com")
      expect(User.email_string).to include("default_user2@gmail.com")
    end

    it '.all_active_merchants' do
      merchant_1 = create(:user, role: 1, created_at: Date.new(1995, 5, 3))
      merchant_2 = create(:user, role: 1, created_at: Date.new(2015, 12, 8))
      merchant_3 = create(:user, role: 1, created_at: Date.new(2002, 9, 10))
      merchant_4 = create(:user, role: 1, created_at: Date.new(1955, 3, 21))
      merchant_5 = create(:user, role: 1, active: false)
      merchant_6 = create(:user, role: 1, active: false)
      user = create(:user)

      expect(User.all_active_merchants).to include(merchant_1)
      expect(User.all_active_merchants).to include(merchant_2)
      expect(User.all_active_merchants).to include(merchant_3)
      expect(User.all_active_merchants).to include(merchant_4)
      expect(User.all_active_merchants).to_not include(merchant_5)
      expect(User.all_active_merchants).to_not include(merchant_6)
      expect(User.all_active_merchants).to_not include(user)
    end

  end

  describe 'instance_methods' do

    before :each do
      @merchant = create(:user, role: 1)
      @item_1 = create(:item, user: @merchant)
      @item_2 = create(:item, user: @merchant)
      @item_3 = create(:item, user: @merchant)
      @item_4 = create(:item, user: @merchant)
      @user_1 = create(:user)
      @user_2 = create(:user)
      @user_3 = create(:user)
      @order_1 = create(:order, user: @user_1, status: 1)
      @order_2 = create(:order, user: @user_2, status: 1)
      @order_3 = create(:order, user: @user_3, status: 0)
      @order_4 = create(:order, user: @user_3, status: 0)
      OrderItem.create!(item: @item_1, order: @order_1, quantity: 12, price: 1.99, fulfilled: false)
      OrderItem.create!(item: @item_2, order: @order_2, quantity: 12, price: 1.99, fulfilled: false)
      OrderItem.create!(item: @item_3, order: @order_3, quantity: 12, price: 1.99, fulfilled: false)
      OrderItem.create!(item: @item_3, order: @order_4, quantity: 12, price: 1.99, fulfilled: false)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
    end

    it 'pending_orders' do
      orders = [@order_1, @order_2]

      expect(@merchant.pending_orders).to eq(orders)
    end
  end
end
