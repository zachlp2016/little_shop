require 'rails_helper'

RSpec.describe 'Edit address page', type: :feature do
  context 'As a regular user' do
    describe 'When I Update address' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")
        @new_address = @user.addresses.create!(nickname: "Second Address", street: "222 Other Address rd", city: "Denver", state: "CO", zip: "80225")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'Im taken to an Update address form' do
        visit profile_path

        within("#address-#{@new_address.id}") do
          click_link('Update Address')
        end

        expect(page).to have_content('Update an Address')

        fill_in 'Nickname', with: 'Work'
        fill_in 'Street', with: '2222 New Street'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80226'

        click_button('Update Address')

        @new_address.reload

        expect(page).to have_content('You have updated your address.')

        visit profile_path

        within "#address-#{@new_address.id}" do

          expect(page).to have_content('Street: 2222 New Street')
          expect(page).to have_content('City: Denver')
          expect(page).to have_content('State: CO')
          expect(page).to have_content('Zip Code: 80226')
        end
      end
    end

    describe 'When I update an address that has a completed order' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")
        @new_address = @user.addresses.create!(nickname: "Second Address", street: "222 Other Address rd", city: "Denver", state: "CO", zip: "80225")
        @merchant_1 = create(:user)
        @merchant_2 = create(:user)
        @item_1 = create(:item, user: @merchant_1)
        @item_2 = create(:item, user: @merchant_1)
        @item_3 = create(:item, user: @merchant_1)
        @order_1 = create(:order, user: @user)
        @order_1.update(status: 2)
        order_item_1 = create(:order_item, order: @order_1, item: @item_1)
        order_item_2 = create(:order_item, order: @order_1, item: @item_2)
        order_item_3 = create(:order_item, order: @order_1, item: @item_3)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'Im taken to an Update address form' do
        visit profile_path

        within("#address-#{@new_address.id}") do
          click_link('Update Address')
        end

        @new_address.reload

        expect(page).to have_content('You cannot update or delete an address if its already being used in an order.')

        visit profile_path

        within "#address-#{@new_address.id}" do
          expect(page).to_not have_content('Street: 2222 New Street')
        end
      end
    end
  end
end
