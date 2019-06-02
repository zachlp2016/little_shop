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

        within("#address-#{new_address.id}") do
          click_link('Delete Address')
        end

        expect(page).to have_content("The address has been deleted.")
        @user.addresses.reload

        visit profile_path

        expect(page).to_not have_content("Nickname: #{new_address.nickname}")
      end
    end
  end
end
