require 'rails_helper'


RSpec.describe 'User can login' do
  describe 'As a regular user' do

    before :each do
      @password = BCrypt::Password.create("password", cost: 4)
      @regular_user = User.create(name: "Regular1", password_digest: @password, role: 0, active: true, address: "88888", city: "Denver", state: "CO", zip: "88888", email: "reg_1@gmail.com")
    end

    it 'It can login' do

      visit login_path

      fill_in 'Email', with: "reg_1@gmail.com"
      fill_in 'Password', with: "password"

      click_button('Login')

      expect(current_path).to eq('/profile')
      expect(page).to have_content('You are now logged in.')
    end
  end
end
#
#
# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to the home page of the site
# And I see a flash message that I am logged in
