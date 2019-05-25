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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_1)
    end

    it 'view show page on a user' do
      visit admin_user_path(@user_1.id)
      
      expect(current_path).to eq(admin_user_path(@user_1.id))

      expect(page).to have_content(@user_1.email)
      expect(page).to have_content(@user_1.role)
      expect(page).to have_content(@user_1.active)
      expect(page).to have_content(@user_1.name)
      expect(page).to have_content(@user_1.address)
      expect(page).to have_content(@user_1.city)
      expect(page).to have_content(@user_1.state)
      expect(page).to have_content(@user_1.zip)

      expect(page).to_not have_content(@user_1.password_digest)
      expect(page).to_not have_link("Edit Profile")

    end
  end
end