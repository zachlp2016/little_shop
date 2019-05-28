require 'rails_helper'

# As a merchant
# When I try to add a new item
# If any of my data is incorrect or missing (except image)
# Then I am returned to the form
# I see one or more flash messages indicating each error I caused
# All fields are re-populated with my previous data
RSpec.describe 'As a merchant' do
  describe 'when adding new items' do
    before :each do
      @merchant_1 = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)
    end

    context 'it wont allow a' do

      it 'missing name' do
        visit dashboard_items_path

        click_link('Add a new item')

        fill_in 'Description', with: 'Glorified Cheese Wizz.'
        fill_in 'Image', with: ''
        fill_in 'Price', with: '3.90'
        fill_in 'Inventory', with: '25'

        click_button "Create Item"

        expect(current_path).to eq(dashboard_items_path)
        expect(status_code).to_not eq(422)
        expect(page).to have_content("Name can't be blank")
      end

      it 'missing description' do
        visit dashboard_items_path

        click_link('Add a new item')


        fill_in 'Name', with: 'Valveeta'
        fill_in 'Image', with: ''
        fill_in 'Price', with: '3.90'
        fill_in 'Inventory', with: '25'

        click_button "Create Item"

        expect(current_path).to eq(dashboard_items_path)
        expect(status_code).to_not eq(422)
        expect(page).to have_content("Description can't be blank")
      end

      it 'missing description and name, and displays messages for both' do
        visit dashboard_items_path

        click_link('Add a new item')

        fill_in 'Image', with: ''
        fill_in 'Price', with: '3.90'
        fill_in 'Inventory', with: '25'

        click_button "Create Item"

        expect(current_path).to eq(dashboard_items_path)
        expect(status_code).to_not eq(422)
        expect(page).to have_content("Description can't be blank")
        expect(page).to have_content("Name can't be blank")
      end

      it 'negative numbers or inventory' do
        visit dashboard_items_path

        click_link('Add a new item')

        fill_in 'Name', with: 'Valveeta'
        fill_in 'Description', with: 'Glorified Cheese Wizz.'
        fill_in 'Image', with: ''
        fill_in 'Price', with: '-3.90'
        fill_in 'Inventory', with: '-25'

        click_button "Create Item"

        expect(page).to have_content("Price must be greater than 0")
        expect(page).to have_content("Inventory must be greater than 0")

      end

    end

    it 'displays ALL error messages' do
      visit dashboard_items_path

      click_link('Add a new item')
      click_button "Create Item"

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Price can't be blank")
      expect(page).to have_content("Price is not a number")
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Inventory can't be blank")
      expect(page).to have_content("Inventory is not a number")
    end

  end
end
