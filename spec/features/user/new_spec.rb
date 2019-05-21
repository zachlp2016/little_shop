require 'rails_helper'

RSpec.describe 'New user form' do
  context 'As a visitor' do
    describe 'When I visit the register new register link' do
      it 'I can register as a new user' do

        visit root_path

        within '.register-link' do
          click_link('Register')
        end

        expect(current_path).to eq(new_user_path)

        fill_in 'Name', with: 'User'
        fill_in 'Address', with: '1111 South One St.'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80000'
        fill_in 'Email', with: 'user@gmail.com'
        fill_in 'Password', with: 'password'
        fill_in 'Confirm password', with: 'password'

        click_button 'Create User'

        new_user = User.last

        expect(current_path).to eq('/profile')
        expect(page).to have_content("Name: #{new_user.name}")
        expect(page).to have_content("Address: #{new_user.address}")
        expect(page).to have_content("City: #{new_user.city}")
        expect(page).to have_content("Zip Code: #{new_user.zip}")
        expect(page).to have_content("Email: #{new_user.email}")
        expect(page).to have_content("You are now registered and logged in.")

      end
    end
  end
end
