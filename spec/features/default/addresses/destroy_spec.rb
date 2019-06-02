require 'rails_helper'

RSpec.describe 'Destroy Address', type: :feature do
  context 'As a regular user' do
    describe 'When I click on a non home address to delete it' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'deletes the address' do
        new_address = @user.addresses.create!(nickname: "Second Address", street: "222 Other Address rd", city: "Denver", state: "CO", zip: "80225")

        visit profile_path

        within("#other-address-#{new_address.id}") do
          click_link('Delete Address')
        end

        expect(page).to have_content("The address has been deleted.")
        @user.addresses.reload

        visit profile_path

        expect(page).to_not have_content("Nickname: #{new_address.nickname}")
      end
    end

    describe 'When I click on a home address to delete it' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'deletes the address' do

        visit profile_path

        within(".home-address") do
          click_link('Delete address')
        end

        expect(page).to have_content("The home address has been deleted.")
        @user.reload


        within(".home-address") do
          expect(page).to have_content("Home Address")
          expect(page).to_not have_content("Street: 123 Test St")
          expect(page).to_not have_content("City: Testville")
          expect(page).to_not have_content("State: Test")
          expect(page).to_not have_content("Zip: 01234")
        end
      end
    end
  end
end
