require 'rails_helper'

RSpec.describe 'User new address page', type: :feature do
  context 'As a regular user' do
    describe 'When I add a new address' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'Im taken to a new address form' do
        visit profile_path

        click_link('Add address')


        expect(page).to have_content('Create a New Address')

        fill_in 'Nickname', with: 'New Address'
        fill_in 'Street', with: '1111 New Street'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80226'

        click_button('Create Address')

        last_address = Address.last

        expect(page).to have_content('You have added a new address')

        within "#other-address-#{last_address.id}" do
          expect(page).to have_content("Nickname: #{last_address.nickname}")
          expect(page).to have_content("Street: #{last_address.street}")
          expect(page).to have_content("City: #{last_address.city}")
          expect(page).to have_content("State: #{last_address.state}")
          expect(page).to have_content("Zip: #{last_address.zip}")
        end
      end
    end
  end
end
