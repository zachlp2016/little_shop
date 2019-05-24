require 'rails_helper'


RSpec.describe 'User can login' do
  describe 'When I go to the login page' do

    before :each do
      @password = BCrypt::Password.create("password", cost: 4)
      @regular_user = User.create(name: "Regular1", password_digest: @password, role: 0, active: true, address: "88888", city: "Denver", state: "CO", zip: "88888", email: "reg_1@gmail.com")
      @password2 = BCrypt::Password.create("password", cost: 4)
      @merchant_user = User.create(name: "Merchant1", password_digest: @password2, role: 1, active: true, address: "88888", city: "Denver", state: "CO", zip: "88888", email: "merchant_1@gmail.com")
      @password3 = BCrypt::Password.create("password", cost: 4)
      @merchant_user = User.create(name: "Admin1", password_digest: @password3, role: 2, active: true, address: "88888", city: "Denver", state: "CO", zip: "88888", email: "admin_1@gmail.com")
    end

    it 'As a regular user, I can login' do

      visit login_path

      fill_in 'Email', with: "reg_1@gmail.com"
      fill_in 'Password', with: "password"

      click_button('Login')

      expect(current_path).to eq("/profile")
      expect(page).to have_content('You are now logged in.')
    end

    it 'As a merchant user, I can login' do

      visit login_path

      fill_in 'Email', with: "merchant_1@gmail.com"
      fill_in 'Password', with: "password"

      click_button('Login')

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('You are now logged in.')
    end

    it 'As a admin user, I can login' do

      visit login_path

      fill_in 'Email', with: "admin_1@gmail.com"
      fill_in 'Password', with: "password"

      click_button('Login')

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You are now logged in.')
    end

    it 'shows error message if credentials are bad' do
      visit login_path

      fill_in 'Email', with: "reg_@gmail.com"
      fill_in 'Password', with: "password"

      click_button('Login')

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Those are the wrong credentials.')
    end
  end

  context 'As a regular user' do
    describe 'When I visit the login page' do
      before :each do
        @regular_user = User.create(name: "Regular1", password_digest: @password, role: 0, active: true, address: "88888", city: "Denver", state: "CO", zip: "88888", email: "reg_1@gmail.com")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@regular_user)
      end

      it 'It redirects me to my profile page' do
        visit login_path

        expect(current_path).to eq(profile_path)
        expect(page).to have_content('You have already logged in.')
      end
    end
  end

  context 'As a merchant user' do
    describe 'When I visit the login page' do
      before :each do
        @merchant = User.create!(name: "Merchant", password_digest: "password", role: 1, active: true, address: "88888", city: "Denver", state: "CO", zip: "88888", email: "merchant@gmail.com")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
      end

      it 'It redirects me to my profile page' do
        visit login_path

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content('You have already logged in.')
      end
    end
  end
end
# As a registered user, merchant, or admin
# When I visit the login path
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to the home page of the site
# And I see a flash message that tells me I am already logged in
