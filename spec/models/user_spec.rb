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

    it '.top_3_merchants_by_sales' do
      merchant_1 = create(:user, role: 1, created_at: Date.new(1995, 5, 3), city: 'Kansas City', state: "MO")
      merchant_2 = create(:user, role: 1, created_at: Date.new(2015, 12, 8), city: 'Springfield', state: 'CO')
      merchant_3 = create(:user, role: 1, created_at: Date.new(2002, 9, 10), city: 'Springfield', state: 'MI')
      merchant_4 = create(:user, role: 1, created_at: Date.new(1955, 3, 21), city: 'Little Rock', state: 'AR')
      merchant_5 = create(:user, role: 1, active: false)
      merchant_6 = create(:user, role: 1, active: false)
      user = create(:user)
      item_1 = create(:item, user: merchant_1)
      item_2 = create(:item, user: merchant_2)
      item_3 = create(:item, user: merchant_3)
      item_4 = create(:item, user: merchant_4)
      item_5 = create(:item, user: merchant_1)
      item_6 = create(:item, user: merchant_5)
      order_1 = create(:order, user: user, status: 2)
      order_2 = create(:order, user: user, status: 2)
      order_3 = create(:order, user: user, status: 2)
      order_4 = create(:order, user: user, status: 2)
      order_5 = create(:order, user: user, status: 1)
      order_item_1 = OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: item_1.price, fulfilled: true, updated_at: Time.now + 30)
      order_item_2 = OrderItem.create!(item: item_2, order: order_1, quantity: 2, price: item_2.price, fulfilled: true, updated_at: Time.now + 40)
      order_item_3 = OrderItem.create!(item: item_3, order: order_1, quantity: 3, price: item_3.price, fulfilled: true, updated_at: Time.now + 50)
      order_item_4 = OrderItem.create!(item: item_4, order: order_1, quantity: 4, price: item_4.price, fulfilled: true, updated_at: Time.now + 60)
      order_item_5 = OrderItem.create!(item: item_1, order: order_2, quantity: 5, price: item_1.price, fulfilled: true, updated_at: Time.now + 80)
      order_item_6 = OrderItem.create!(item: item_2, order: order_2, quantity: 6, price: item_2.price, fulfilled: true, updated_at: Time.now + 90)
      order_item_7 = OrderItem.create!(item: item_3, order: order_2, quantity: 7, price: item_3.price, fulfilled: true, updated_at: Time.now + 100)
      order_item_8 = OrderItem.create!(item: item_1, order: order_3, quantity: 8, price: item_1.price, fulfilled: true, updated_at: Time.now + 110)
      order_item_9 = OrderItem.create!(item: item_2, order: order_3, quantity: 9, price: item_2.price, fulfilled: true, updated_at: Time.now + 120)
      order_item_10 = OrderItem.create!(item: item_1, order: order_4, quantity: 10, price: item_1.price, fulfilled: true, updated_at: Time.now + 130)
      order_item_10 = OrderItem.create!(item: item_5, order: order_1, quantity: 11, price: item_5.price, fulfilled: true, updated_at: Time.now + 70)
      order_item_11 = OrderItem.create!(item: item_6, order: order_5, quantity: 12, price: item_6.price, fulfilled: true, updated_at: Time.now + 70)

      expect(User.top_3_merchants_by_sales[0]).to eq(merchant_1)
      expect(User.top_3_merchants_by_sales[1]).to eq(merchant_2)
      expect(User.top_3_merchants_by_sales[2]).to eq(merchant_3)
    end

    it '.fastest_fulfilling_merchants and .slowest_fulfilling_merchants' do
      merchant_1 = create(:user, role: 1, created_at: Date.new(1995, 5, 3), city: 'Kansas City', state: "MO")
      merchant_2 = create(:user, role: 1, created_at: Date.new(2015, 12, 8), city: 'Springfield', state: 'CO')
      merchant_3 = create(:user, role: 1, created_at: Date.new(2002, 9, 10), city: 'Springfield', state: 'MI')
      merchant_4 = create(:user, role: 1, created_at: Date.new(1955, 3, 21), city: 'Little Rock', state: 'AR')
      merchant_5 = create(:user, role: 1, active: false)
      merchant_6 = create(:user, role: 1, active: false)
      user = create(:user)
      item_1 = create(:item, user: merchant_1)
      item_2 = create(:item, user: merchant_2)
      item_3 = create(:item, user: merchant_3)
      item_4 = create(:item, user: merchant_4)
      item_5 = create(:item, user: merchant_1)
      item_6 = create(:item, user: merchant_5)
      order_1 = create(:order, user: user, status: 2)
      order_2 = create(:order, user: user, status: 2)
      order_3 = create(:order, user: user, status: 2)
      order_4 = create(:order, user: user, status: 2)
      order_5 = create(:order, user: user, status: 1)
      order_item_1 = OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: item_1.price, fulfilled: true, updated_at: Time.now + 30)
      order_item_2 = OrderItem.create!(item: item_2, order: order_1, quantity: 2, price: item_2.price, fulfilled: true, updated_at: Time.now + 40)
      order_item_3 = OrderItem.create!(item: item_3, order: order_1, quantity: 3, price: item_3.price, fulfilled: true, updated_at: Time.now + 50)
      order_item_4 = OrderItem.create!(item: item_4, order: order_1, quantity: 4, price: item_4.price, fulfilled: true, updated_at: Time.now + 60)
      order_item_5 = OrderItem.create!(item: item_1, order: order_2, quantity: 5, price: item_1.price, fulfilled: true, updated_at: Time.now + 80)
      order_item_6 = OrderItem.create!(item: item_2, order: order_2, quantity: 6, price: item_2.price, fulfilled: true, updated_at: Time.now + 90)
      order_item_7 = OrderItem.create!(item: item_3, order: order_2, quantity: 7, price: item_3.price, fulfilled: true, updated_at: Time.now + 100)
      order_item_8 = OrderItem.create!(item: item_1, order: order_3, quantity: 8, price: item_1.price, fulfilled: true, updated_at: Time.now + 110)
      order_item_9 = OrderItem.create!(item: item_2, order: order_3, quantity: 9, price: item_2.price, fulfilled: true, updated_at: Time.now + 120)
      order_item_10 = OrderItem.create!(item: item_1, order: order_4, quantity: 10, price: item_1.price, fulfilled: true, updated_at: Time.now + 130)
      order_item_10 = OrderItem.create!(item: item_5, order: order_1, quantity: 11, price: item_5.price, fulfilled: true, updated_at: Time.now + 70)
      order_item_11 = OrderItem.create!(item: item_6, order: order_5, quantity: 12, price: item_6.price, fulfilled: true, updated_at: Time.now + 70)

      expect(User.fastest_3_fulfilling_merchants[0]).to eq(merchant_4)
      expect(User.fastest_3_fulfilling_merchants[1]).to eq(merchant_3)
      expect(User.fastest_3_fulfilling_merchants[2]).to eq(merchant_2)
      expect(User.fastest_3_fulfilling_merchants.length).to eq(3)

      expect(User.slowest_3_fulfilling_merchants[0]).to eq(merchant_1)
      expect(User.slowest_3_fulfilling_merchants[1]).to eq(merchant_2)
      expect(User.slowest_3_fulfilling_merchants[2]).to eq(merchant_3)
      expect(User.slowest_3_fulfilling_merchants.length).to eq(3)
    end

    it '.top_3_states' do
      merchant_1 = create(:user, role: 1, created_at: Date.new(1995, 5, 3), city: 'Kansas City', state: "MO")
      merchant_2 = create(:user, role: 1, created_at: Date.new(2015, 12, 8), city: 'Springfield', state: 'CO')
      merchant_3 = create(:user, role: 1, created_at: Date.new(2002, 9, 10), city: 'Springfield', state: 'MI')
      merchant_4 = create(:user, role: 1, created_at: Date.new(1955, 3, 21), city: 'Little Rock', state: 'AR')
      merchant_5 = create(:user, role: 1, active: false)
      merchant_6 = create(:user, role: 1, active: false)
      user = create(:user)
      item_1 = create(:item, user: merchant_1)
      item_2 = create(:item, user: merchant_2)
      item_3 = create(:item, user: merchant_3)
      item_4 = create(:item, user: merchant_4)
      item_5 = create(:item, user: merchant_1)
      item_6 = create(:item, user: merchant_5)
      order_1 = create(:order, user: user, status: 2)
      order_2 = create(:order, user: user, status: 2)
      order_3 = create(:order, user: user, status: 2)
      order_4 = create(:order, user: user, status: 2)
      order_5 = create(:order, user: user, status: 1)
      order_item_1 = OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: item_1.price, fulfilled: true, updated_at: Time.now + 30)
      order_item_2 = OrderItem.create!(item: item_2, order: order_1, quantity: 2, price: item_2.price, fulfilled: true, updated_at: Time.now + 40)
      order_item_3 = OrderItem.create!(item: item_3, order: order_1, quantity: 3, price: item_3.price, fulfilled: true, updated_at: Time.now + 50)
      order_item_4 = OrderItem.create!(item: item_4, order: order_1, quantity: 4, price: item_4.price, fulfilled: true, updated_at: Time.now + 60)
      order_item_5 = OrderItem.create!(item: item_1, order: order_2, quantity: 5, price: item_1.price, fulfilled: true, updated_at: Time.now + 80)
      order_item_6 = OrderItem.create!(item: item_2, order: order_2, quantity: 6, price: item_2.price, fulfilled: true, updated_at: Time.now + 90)
      order_item_7 = OrderItem.create!(item: item_3, order: order_2, quantity: 7, price: item_3.price, fulfilled: true, updated_at: Time.now + 100)
      order_item_8 = OrderItem.create!(item: item_1, order: order_3, quantity: 8, price: item_1.price, fulfilled: true, updated_at: Time.now + 110)
      order_item_9 = OrderItem.create!(item: item_2, order: order_3, quantity: 9, price: item_2.price, fulfilled: true, updated_at: Time.now + 120)
      order_item_10 = OrderItem.create!(item: item_1, order: order_4, quantity: 10, price: item_1.price, fulfilled: true, updated_at: Time.now + 130)
      order_item_10 = OrderItem.create!(item: item_5, order: order_1, quantity: 11, price: item_5.price, fulfilled: true, updated_at: Time.now + 70)
      order_item_11 = OrderItem.create!(item: item_6, order: order_5, quantity: 12, price: item_6.price, fulfilled: true, updated_at: Time.now + 70)

      expect(User.top_3_states[0].state).to eq("MO")
      expect(User.top_3_states[0].count).to eq(4)
      expect(User.top_3_states[1].state).to eq("CO")
      expect(User.top_3_states[1].count).to eq(3)
      expect(User.top_3_states[2].state).to eq("MI")
      expect(User.top_3_states[2].count).to eq(2)
      expect(User.top_3_states.length).to eq(3)
    end

  end
end
