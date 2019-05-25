require 'rails_helper'

RSpec.describe 'As an admin user' do
  describe 'when i click a new Users link' do
    before :each do
      @admin_1 = User.create!(email: "ron_admin@gmail.com", password: "12345", role: 2, active: true, name: "Ron", address: "1234 Test Rd", city: "Kansas City", state: "MO", zip: '64086')

      @merchant_1 = User.create!(email: "jon_mer@gmail.com", password: "12345", role: 1, active: true, name: "Jon a", address: "1234 Test Rd", city: "Kansas City", state: "MO", zip: '64086')
      @merchant_2 = User.create!(email: "ron_mer@gmail.com", password: "12345", role: 1, active: true, name: "Ron b", address: "1234 Test Rd", city: "Kansas City", state: "MO", zip: '64086')
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

    it 'when viewing my dashboard page, I see all orders' do
      visit admin_dashboard_path

      within "#order-#{@o1.id}" do
        expect(page).to have_content(@o1.user.name)
        expect(page).to have_content(@o1.id)
        expect(page).to have_content(@o1.created_at.strftime("%b %d, %Y"))
      end
      within "#order-#{@o2.id}" do
        expect(page).to have_content(@o2.user.name)
        expect(page).to have_content(@o2.id)
        expect(page).to have_content(@o2.created_at.strftime("%b %d, %Y"))
      end
      within "#order-#{@o7.id}" do
        expect(page).to have_content(@o7.user.name)
        expect(page).to have_content(@o7.id)
        expect(page).to have_content(@o7.created_at.strftime("%b %d, %Y"))
      end
    end

    it 'when viewing my dashboard page, I see all orders in order' do
      visit admin_dashboard_path

      within("#dataTable") do
        text = page.current_scope.text
        # require 'pry'; binding.pry
        expect(text.index("#{@o1.id} #{@o1.user.name}") < text.index("#{@o5.id} #{@o5.user.name}")).to be true
        expect(text.index("#{@o5.id} #{@o5.user.name}") < text.index("#{@o2.id} #{@o2.user.name}")).to be true
        expect(text.index("#{@o2.id} #{@o2.user.name}") < text.index("#{@o6.id} #{@o6.user.name}")).to be true
        expect(text.index("#{@o6.id} #{@o6.user.name}") < text.index("#{@o7.id} #{@o7.user.name}")).to be true
        expect(text.index("#{@o7.id} #{@o7.user.name}") < text.index("#{@o3.id} #{@o3.user.name}")).to be true
        expect(text.index("#{@o3.id} #{@o3.user.name}") < text.index("#{@o4.id} #{@o4.user.name}")).to be true
    end
    end
  end
end