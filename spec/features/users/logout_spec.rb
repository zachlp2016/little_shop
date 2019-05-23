require 'rails_helper'

# As a registered user, merchant, or admin
# When I visit the logout path
# I am redirected to the welcome / home page of the site
# And I see a flash message that indicates I am logged out
# Any items I had in my shopping cart are deleted

RSpec.describe 'when logging out' do

  before :each do
    @user = create(:user, email: 'reg@gmail.com', password: 'password', role: 0)
    @merchant = create(:user, email: 'merchant@gmail.com', password: 'password', role: 1)
    @admin = create(:user, email: 'admin@gmail.com', password: 'password', role: 2)
    @item = create(:item, user: @merchant)
  end

  context 'as a user' do

    it 'logs out and clears cart' do
      visit items_path
      click_button "Add To Cart"
      click_button "Add To Cart"

      visit login_path

      fill_in 'Email', with: "reg@gmail.com"
      fill_in 'Password', with: "password"

      click_button('Login')

      expect(page).to have_content("(2)")

      click_link('Logout')

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Succesfully Logged Out")
      expect(page).to have_content("(0)")
    end

  end

  context 'as a merchant' do

    it 'logs out' do
      visit items_path
      click_button "Add To Cart"
      click_button "Add To Cart"

      visit login_path

      fill_in 'Email', with: "merchant@gmail.com"
      fill_in 'Password', with: "password"

      click_button('Login')
      click_link('Logout')

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Succesfully Logged Out")
    end

  end

  context 'as an admin' do

    it 'logs out' do
      visit items_path
      click_button "Add To Cart"
      click_button "Add To Cart"

      visit login_path

      fill_in 'Email', with: "admin@gmail.com"
      fill_in 'Password', with: "password"

      click_button('Login')
      click_link('Logout')

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Succesfully Logged Out")
    end

  end

end
