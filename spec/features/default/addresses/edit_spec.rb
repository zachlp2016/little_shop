require 'rails_helper'

RSpec.describe 'Edit address page', type: :feature do
  context 'As a regular user' do
    describe 'When I add Update My home address' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'Im taken to an Update address form' do
        visit profile_path

        within('.home-address') do
          click_link('Add address')
        end

        expect(page).to have_content('Update an Address')

        fill_in 'Nickname', with: 'Updated Address'
        fill_in 'Street', with: '2222 New Street'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80226'

        click_button('Update Address')

        expect(page).to have_content('You have added a new address')

        within ".home-address" do
          expect(page).to have_content("Street: #{@user.address}")
          expect(page).to have_content("City: #{@user.city}")
          expect(page).to have_content("State: #{@user.state}")
          expect(page).to have_content("Zip: #{@user.zip}")
        end
      end
    end
  end
end
