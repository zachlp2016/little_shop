require 'rails_helper'

RSpec.describe 'New user form' do
  context 'As a visitor' do
    describe 'When I visit the register new register link' do

      it 'I can register as a new user' do
        visit register_path

        fill_in 'Name', with: 'User'
        fill_in 'Street', with: '1111 South One St.'
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
        expect(page).to have_content("Email: #{new_user.email}")
        expect(page).to have_content("You are now registered and logged in.")
      end

      it 'I throws flash message when password isnt the same' do
        visit register_path

        fill_in 'Name', with: 'User'
        fill_in 'Street', with: '1111 South One St.'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80000'
        fill_in 'Email', with: 'user@gmail.com'
        fill_in 'Password', with: 'password'
        fill_in 'Confirm password', with: 'password3'

        click_button 'Create User'

        expect(current_path).to eq(register_path)

        expect(page).to have_content("Those passwords don't match.")
      end


      it 'Can not use an already used email address' do
        user_2 = User.create!(name: "User_1", role: 0, active: true, password_digest: "8320280282", address: "333", city: "Denver", zip: "80000", email: "user_1@gmail.com", state: 'IL' )

        visit register_path

        fill_in 'Name', with: 'User_2'
        fill_in 'Street', with: '1111 South One St.'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80000'
        fill_in 'Email', with: 'user_1@gmail.com'
        fill_in 'Password', with: 'password'
        fill_in 'Confirm password', with: 'password'

        click_button 'Create User'

        new_user = User.last
        expect(page).to have_content("Email has already been taken")
        expect(new_user.name).to eq('User_1')
      end
    end

    it 'Will not let me register if fields are missing' do
      visit register_path

      fill_in 'Name', with: ''
      fill_in 'Street', with: '1111 South One St.'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: ''
      fill_in 'Zip', with: '80000'
      fill_in 'Email', with: 'user_1@gmail.com'
      fill_in 'Password', with: ''
      fill_in 'Confirm password', with: ''

      click_button 'Create User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Password can't be blank")
    end

    it 'Will add the first address as a home address' do
      visit register_path

      fill_in 'Name', with: 'Mike'
      fill_in 'Street', with: '1111 South One St.'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'Colorado'
      fill_in 'Zip', with: '80000'
      fill_in 'Email', with: 'user_1@gmail.com'
      fill_in 'Password', with: '123456'
      fill_in 'Confirm password', with: '123456'

      click_button 'Create User'

      new_user = User.last
      new_address = User.last.addresses.last

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('Addresses')
      within "#address-#{new_address.id}" do
        expect(page).to have_content("Nickname: home")
        expect(page).to have_content("Street: #{new_address.street}")
        expect(page).to have_content("City: #{new_address.city}")
        expect(page).to have_content("State: #{new_address.state}")
        expect(page).to have_content("Zip Code: #{new_address.zip}")
      end
    end
  end
end
