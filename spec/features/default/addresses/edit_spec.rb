require 'rails_helper'

RSpec.describe 'Edit address page', type: :feature do
  context 'As a regular user' do
    describe 'When I Update My home address' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'Im taken to an Update address form' do
        visit profile_path

        within('.home-address') do
          click_link('Update address')
        end

        expect(page).to have_content('Update an Address')

        fill_in 'Address nickname', with: 'home'
        fill_in 'Address', with: '2222 New Street'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80226'

        click_button('Update Address')

        expect(page).to have_content('You have updated your home address.')

        @user.reload

        within ".home-address" do
          expect(page).to have_content('Street: 2222 New Street')
          expect(page).to have_content('City: Denver')
          expect(page).to have_content('State: CO')
          expect(page).to have_content('Zip Code: 80226')
        end
      end
    end

    describe 'When I update an address that isnt my home address' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

        @other_address = @user.addresses.create!(nickname: "Second Address", street: "222 Other Address rd", city: "Denver", state: "CO", zip: "80225")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end

      it 'Im taken to an Update address form' do
        visit profile_path

        within("#other-address-#{@other_address.id}") do
          click_link('Update address')
        end

        expect(page).to have_content('Update an Address')

        fill_in 'Nickname', with: 'Second Address'
        fill_in 'Street', with: '2222 New Street'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80226'

        click_button('Update Address')

        @other_address.reload

        expect(page).to have_content('You have updated that address.')

        within "#other-address-#{@other_address.id}" do
          expect(page).to have_content('Nickname: Second Address')
          expect(page).to have_content('Street: 2222 New Street')
          expect(page).to have_content('City: Denver')
          expect(page).to have_content('State: CO')
          expect(page).to have_content('Zip: 80226')
        end
      end
    end

    describe 'When I update an address that has a completed order' do
      before :each do
        @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")
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

      xit 'Im not allowed to update an address if an order has been shipped' do
        visit profile_path

        within("#other-address-#{@other_address.id}") do
          click_link('Update address')
        end

        expect(page).to have_content('Update an Address')

        fill_in 'Nickname', with: 'Second Address'
        fill_in 'Street', with: '2222 New Street'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'CO'
        fill_in 'Zip', with: '80226'

        click_button('Update Address')

        @other_address.reload

        expect(page).to have_content("That address belongs to an order and can't be updated.")

        within "#other-address-#{@other_address.id}" do
          expect(page).to have_content('Nickname: Second Address')
          expect(page).to have_content('Street: 2222 New Street')
          expect(page).to have_content('City: Denver')
          expect(page).to have_content('State: CO')
          expect(page).to have_content('Zip: 80226')
        end
      end
    end
  end
end
