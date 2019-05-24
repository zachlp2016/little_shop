require 'rails_helper'

RSpec.describe 'Cart Show Spec' do
  context 'As a visitor' do
    before :each do
      @user = User.create!(email: "test@test.com", password_digest: "t3s7", role: 1, active: true, name: "Testy McTesterson", address: "123 Test St", city: "Testville", state: "Test", zip: "01234")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it 'When my cart is empty and I visit my cart, It says my cart is empty' do
      visit carts_path

      expect(page).to have_content('Your cart is currently empty.')
      expect(page).to_not have_content('Empty your Cart')
    end
  end
end
