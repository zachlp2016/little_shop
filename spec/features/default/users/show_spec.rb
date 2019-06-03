require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  context 'As a regular user' do
    describe 'When I visit my own profile page' do
      before :each do
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

        @user = User.last
        @new_address = User.last.addresses.last


        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'Then I can see all my information, except my password' do
        visit profile_path

        expect(page).to have_content(@user.email)
        expect(page).to have_content(@user.role)
        expect(page).to have_content(@user.active)
        expect(page).to have_content(@user.name)

        within "#address-#{@new_address.id}" do
          expect(page).to have_content(@new_address.nickname)
          expect(page).to have_content(@new_address.street)
          expect(page).to have_content(@new_address.city)
          expect(page).to have_content(@new_address.state)
          expect(page).to have_content(@new_address.zip)
        end

        expect(page).to_not have_content(@user.password_digest)
      end

      it 'I see a link to edit my information' do
        visit profile_path

        expect(page).to have_link("Edit Profile")

        click_on "Edit Profile"

        expect(current_path).to eq("/profile/edit")
      end

      it 'Sees a link to add new address' do
        visit profile_path

        within '.add-address' do
          click_link('Add address')
        end

        expect(current_path).to eq(new_user_address_path(@user))
      end
    end
    describe 'And I have orders placed in the system' do

      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'I can click on My Orders and navigate to profile/orders' do
        order_1 = @user.orders.create!(status: 0)

        visit profile_path

        expect(page).to have_link("My Orders")

        click_on "My Orders"

        expect(current_path).to eq(profile_orders_path)
      end
    end
    describe 'And I do not have orders placed in the system' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'I do not see My Orders link' do
        visit profile_path

        expect(page).to have_no_link("My Orders")
      end
    end
  end
end
