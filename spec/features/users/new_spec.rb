require 'rails_helper'

RSpec.describe 'New user form' do
  context 'As a visitor' do
    describe 'When I visit the register new register link' do

      before :each do
        @user_1 = User.create!(name: "default_user", role: 0, active: true, password_digest: "8320280282", address: "333", city: "Denver", state: "CO", zip: "80000", email: "default_user@gmail.com" )
      end

      it 'I can register as a new user' do


        visit root_path

        within '.navbar' do
          click_link('Register')
        end

        expect(current_path).to eq(register_path)

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


        expect(current_path).to eq("/profile")

        expect(page).to have_content("#{new_user.name}")
        expect(page).to have_content("Address: #{new_user.address}")
        expect(page).to have_content("City: #{new_user.city}")
        expect(page).to have_content("Zip Code: #{new_user.zip}")
        expect(page).to have_content("Email: #{new_user.email}")
        expect(page).to have_content("You are now registered and logged in.")

      end

      it 'I throws flash message when password isnt the same' do


        visit root_path

        click_link('Register')


        expect(current_path).to eq(register_path)

        fill_in 'Name', with: 'User'
        fill_in 'Address', with: '1111 South One St.'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80000'
        fill_in 'Email', with: 'user@gmail.com'
        fill_in 'Password', with: 'password'
        fill_in 'Confirm password', with: 'password3'

        click_button 'Create User'


        new_user = User.last


        expect(current_path).to eq(register_path)

        expect(page).to have_content("Those passwords don't match.")

      end


      it 'Can not use an already used email address' do
        user_2 = User.create!(name: "User_1", role: 0, active: true, password_digest: "8320280282", address: "333", city: "Denver", zip: "80000", email: "user_1@gmail.com", state: 'IL' )

        visit root_path

        within '.navbar' do
          click_link('Register')
        end

        fill_in 'Name', with: 'User_2'
        fill_in 'Address', with: '1111 South One St.'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80000'
        fill_in 'Email', with: 'user_1@gmail.com'
        fill_in 'Password', with: 'password'
        fill_in 'Confirm password', with: 'password'

        click_button 'Create User'

        new_user = User.last
        expect(page).to have_content("That email address is already taken.")
        expect(new_user.name).to eq('User_1')
      end
    end

    it 'Will not let me register if fields are missing' do
      visit root_path

      within '.navbar' do
        click_link('Register')
      end

      fill_in 'Name', with: ''
      fill_in 'Address', with: ''
      fill_in 'City', with: ''
      fill_in 'State', with: ''
      fill_in 'Zip', with: ''
      fill_in 'Email', with: 'user_1@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Confirm password', with: 'password'

      click_button 'Create User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Some required fields are missing.")
    end
  end
end
#
# As a visitor
# When I visit the user registration page
# And I do not fill in this form completely,
# I am returned to the registration page
# And I see a flash message indicating that I am missing required fields
