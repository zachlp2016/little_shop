require 'rails_helper'

RSpec.describe 'As a Registered User', type: :feature do
  describe 'When I visit my own profile page' do
    before :each do
      @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 1, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'Then I can see all my information, except my password' do
      visit profile_path

      expect(page).to have_content(@user.email)
      expect(page).to have_content(@user.role)
      expect(page).to have_content(@user.active)
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.address)
      expect(page).to have_content(@user.city)
      expect(page).to have_content(@user.state)
      expect(page).to have_content(@user.zip)

      expect(page).to_not have_content(@user.password_digest)
    end

    it 'I see a link to edit my information' do
      visit profile_path

      expect(page).to have_link("Edit Profile")

      click_on "Edit Profile"

      expect(current_path).to eq("/profile/edit")
    end
  end
end
