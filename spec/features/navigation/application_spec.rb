require 'rails_helper'

RSpec.describe 'within main navigation' do
  context 'as a visitor' do
    describe 'navbar includes the following' do
      it 'a link to return to the welcome / home page of the application ("/")' do
        visit root_path

        within '.navbar' do
          find('img.cheese-icon').click
        end
        expect(current_path).to eq(root_path)
      end

      it 'a link to browse all items for sale ("/items")' do
        visit root_path

        within '.navbar' do
          click_link('Cheese')
        end
        expect(current_path).to eq(items_path)
      end

      it 'a link to see all merchants ("/merchants")' do
        visit root_path

        within '.navbar' do
          click_link('Merchants')
        end
        expect(current_path).to eq(merchants_path)
      end

      it 'a link to my shopping cart ("/cart")' do
        visit root_path

        within '.navbar' do
          click_link('Cart')
        end
        expect(current_path).to eq(carts_path)
      end

      it 'a link to log in ("/login")' do
        visit root_path

        within '.navbar' do
          click_link('Login')
        end
        expect(current_path).to eq(login_path)
      end

      it 'a link to the user registration page ("/register")' do
        visit root_path

        within '.navbar' do
          click_link('Register')
        end
        expect(current_path).to eq(register_path)
      end
    end
  end
end