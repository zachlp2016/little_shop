require 'rails_helper'

RSpec.describe 'when visiting the merchants index page' do
  describe 'all merchants are visible' do
    describe 'who are active' do
      before :each do
        @merchant_1 = create(:user, role: 1, created_at: Date.new(1995, 5, 3))
        @merchant_2 = create(:user, role: 1, created_at: Date.new(2015, 12, 8))
        @merchant_3 = create(:user, role: 1, created_at: Date.new(2002, 9, 10))
        @merchant_4 = create(:user, role: 1, created_at: Date.new(1955, 3, 21))
        @merchant_5 = create(:user, role: 1, active: false)
        @merchant_6 = create(:user, role: 1, active: false)
        user = create(:user)
      end

      it 'shows merchant name, city, state, date registered' do
        visit merchants_path

        within "#merchant-#{@merchant_1.id}" do
          expect(page).to have_content(@merchant_1.name)
          expect(page).to have_content(@merchant_1.city)
          expect(page).to have_content(@merchant_1.state)
          expect(page).to have_content(@merchant_1.created_at.strftime("%B %d, %Y"))
        end

        within "#merchant-#{@merchant_2.id}" do
          expect(page).to have_content(@merchant_2.name)
          expect(page).to have_content(@merchant_2.city)
          expect(page).to have_content(@merchant_2.state)
          expect(page).to have_content(@merchant_2.created_at.strftime("%B %d, %Y"))
        end

        within "#merchant-#{@merchant_3.id}" do
          expect(page).to have_content(@merchant_3.name)
          expect(page).to have_content(@merchant_3.city)
          expect(page).to have_content(@merchant_3.state)
          expect(page).to have_content(@merchant_3.created_at.strftime("%B %d, %Y"))
        end

        within "#merchant-#{@merchant_4.id}" do
          expect(page).to have_content(@merchant_4.name)
          expect(page).to have_content(@merchant_4.city)
          expect(page).to have_content(@merchant_4.state)
          expect(page).to have_content(@merchant_4.created_at.strftime("%B %d, %Y"))
        end
        expect(page).to_not have_content(@merchant_5.name)
        expect(page).to_not have_content(@merchant_6.name)
      end
    end
    describe 'as an admin ' do
      before :each do
        @admin_1 = User.create!(email: "ron_admin@gmail.com", password: "12345", role: 2, active: true, name: "Ron", address: "1234 Test Rd", city: "Kansas City", state: "MO", zip: '64086')
  
        @m1 = User.create!(email: "jon_mer@gmail.com", password: "12345", role: 1, active: true, name: "Jon a", address: "1234 Test Rd", city: "Kansas City", state: "MO", zip: '64086')
        @m2 = User.create!(email: "ron_mer@gmail.com", password: "12345", role: 1, active: false, name: "Ron b", address: "1234 Test Rd", city: "Kansas City", state: "MO", zip: '64086')
        @user_1 = User.create!(email: "user1@gmail.com", password: "12345", role: 0, active: true, name: "Jon 1", address: "1234 Test Rd", city: "Kansas City", state: "MO", zip: '64086')
        @user_2 = User.create!(email: "user2@gmail.com", password: "12345", role: 0, active: true, name: "Ron 2", address: "1234 Test Rd", city: "Kansas City", state: "MO", zip: '64086')
        @user_3 = User.create!(email: "user3@gmail.com", password: "12345", role: 0, active: true, name: "Jon 3", address: "1234 Test Rd", city: "Kansas City", state: "MO", zip: '64086')
  
        @o1 = Order.create!(user: @user_1, status: 0)
        @o2 = Order.create!(user: @user_1, status: 1)
        @o3 = Order.create!(user: @user_2, status: 2)
        @o4 = Order.create!(user: @user_2, status: 3)
        @o5 = Order.create!(user: @user_3, status: 0)
        @o6 = Order.create!(user: @user_3, status: 1)
        @o7 = Order.create!(user: @user_3, status: 2)
  
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)
      end

      it 'shows a disable enable button next to each merchant' do
        visit merchants_path

        within "#merchant-#{@m1.id}" do
          expect(page).to have_link(@m1.name)
          expect(page).to have_link("Disable")
        end
        within "#merchant-#{@m2.id}" do
          expect(page).to have_link(@m2.name)
          expect(page).to have_link("Enable")
        end
      end

      it 'can disable a merchant' do
        visit merchants_path

        within "#merchant-#{@m1.id}" do
          click_on("Disable")
        end

        expect(current_path).to eq(merchants_path)

        within("#flash-message") do
          expect(page).to have_content("Merchant's account is now disabled")
        end

        within "#merchant-#{@m1.id}" do
          expect(page).to have_link("Enable")
          expect(@m1.active).to eq(true)
        end
      end

      it 'can enable a merchant' do
        visit merchants_path

        within "#merchant-#{@m2.id}" do
          click_on("Enable")
        end

        expect(current_path).to eq(merchants_path)

        within("#flash-message") do
          expect(page).to have_content("Merchant's account is now enabled")
        end

        within "#merchant-#{@m2.id}" do
          expect(page).to have_link("Disable")
          expect(@m2.active).to eq(false)
        end
      end
    end
  end
end

# This merchant cannot log in