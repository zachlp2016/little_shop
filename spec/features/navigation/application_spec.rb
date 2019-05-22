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

      it 'i do not see a link to logout or profile' do
        visit root_path

        within '.navbar' do
          expect(page).to have_no_link('Logout')
          expect(page).to have_no_link('Profile')
        end
      end
    end
  end

  context 'as a registered user' do
    before :each do
      @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 0, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

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

      it 'a link to my profile page ("/profile")' do
        visit root_path

        within '.navbar' do
          click_link('Profile')
        end
        expect(current_path).to eq(profile_path)
      end

      it 'a link to log out ("/logout")' do
        visit root_path

        within '.navbar' do
          click_link('Logout')
        end
        expect(current_path).to eq(root_path)
      end

      it 'i do not see a link to log in or register' do
        visit root_path

        within '.navbar' do
          expect(page).to have_no_link('Login')
          expect(page).to have_no_link('Register')
        end
      end

      it 'i see text that says Logged in as {user.name}' do
        visit root_path
        within '.navbar' do
          expect(page).to have_content("Logged in as #{@user.name}")
        end
      end
    end
  end

  context 'as a merchant user' do
    describe 'Navbar includes the following' do

      before :each do
        @user_1 = User.create!(email: "test@test.com", password_digest: "t3s7", role: 1, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      end

      it 'it has a link to My Dashboard' do

      visit root_path

        within '.navbar' do
          expect(page).to have_link('My Dashboard')
        end
      end

      it 'it has a link to logout' do

      visit root_path

        within '.navbar' do
          expect(page).to have_link('Logout')
        end
      end

      it 'doesnt have link for login/logot or shopping cart' do

      visit root_path

        within '.navbar' do
          expect(page).to_not have_link('Login')
          expect(page).to_not have_link('Register')
        end
      end
    end
  end
end

#
# Minus the following links/info:
# - I do not see a link to log in or register
# - a link to my shopping cart ("/cart") or count of cart items
