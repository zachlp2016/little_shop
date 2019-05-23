require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  context 'As a regular user' do
    describe 'When I visit my own profile page' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

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

      describe 'And I have orders placed in the system' do
        it 'I can click on My Orders and navigate to profile/orders' do
          order_1 = @user.orders.create!(status: 0)

          visit profile_path

          expect(page).to have_link("My Orders")

          click_on "My Orders"

          expect(current_path).to eq(profile_orders_path(@user))
        end
      end
      describe 'And I do not have orders placed in the system' do
        it 'I do not see My Orders link' do
          visit profile_path

          expect(page).to have_no_link("My Orders")
        end
      end
    end
  end

  context 'As a merchant user' do
    describe 'When I visit my dashboard' do
      before :each do
        @merchant = User.create!(email: "test@test.com", password_digest: "t3s7", role: 1, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
      end

      it 'I see my profile data' do
        visit dashboard_path


        expect(page).to have_content(@merchant.email)
        expect(page).to have_content(@merchant.role)
        expect(page).to have_content(@merchant.active)
        expect(page).to have_content(@merchant.name)
        expect(page).to have_content(@merchant.address)
        expect(page).to have_content(@merchant.city)
        expect(page).to have_content(@merchant.state)
        expect(page).to have_content(@merchant.zip)

        expect(page).to_not have_content(@merchant.password_digest)
      end
    end
  end
end
