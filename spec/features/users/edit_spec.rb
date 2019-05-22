require 'rails_helper'

RSpec.describe 'As a registered User', type: :feature do
  context 'Default user' do
    describe 'And I click the link to edit my profile' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 1, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'Has the current path of /profile/edit' do
        visit profile_path

        click_link "Edit Profile"

        expect(current_path).to eq(profile_edit_path)
      end

      it 'Has a form to modify my information' do
        visit profile_edit_path

        expect(page).to have_field("Name")
        expect(page).to have_field("Password")
        expect(page).to have_field("Confirm Password")
        expect(page).to have_field("Address")
        expect(page).to have_field("City")
        expect(page).to have_field("State")
        expect(page).to have_field("Zip")
        expect(page).to have_field("Email")

        expect(page).to have_button("Edit User")
      end

      it 'Has a form with my information already filled out, except Password/Confirm Password' do
        visit profile_edit_path

        expect(page).to have_field("Name", with: "Testy McTesterson")
        expect(find_field("Password").value).blank?
        expect(find_field("Confirm Password").value).blank?
        expect(page).to have_field("Address", with: "123 Test St")
        expect(page).to have_field("City", with: "Testville")
        expect(page).to have_field("State", with: "Test")
        expect(page).to have_field("Zip", with: "01234")
        expect(page).to have_field("Email", with: "test@test.com")
      end

      it 'Can successfully edit one of my fields' do
        visit profile_edit_path

        fill_in "Name", with: "Testerino"

        click_button "Edit User"

        expect(current_path).to eq(profile_path)
        expect(page).to have_content("Testerino")
      end
    end
  end
end
