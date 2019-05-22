require 'rails_helper'
# As a registered user, merchant, or admin
# When I visit the logout path
# I am redirected to the welcome / home page of the site
# And I see a flash message that indicates I am logged out
# Any items I had in my shopping cart are deleted

RSpec.describe "when visiting the logout path" do

  before :each do
    @password = BCrypt::Password.create("password", cost: 4)
    @regular_user = User.create(name: "Regular1", password_digest: @password, role: 0, active: true, address: "88888", city: "Denver", state: "CO", zip: "88888", email: "reg_1@gmail.com")
    @password2 = BCrypt::Password.create("password", cost: 4)
    @merchant_user = User.create(name: "Merchant1", password_digest: @password2, role: 1, active: true, address: "88888", city: "Denver", state: "CO", zip: "88888", email: "merchant_1@gmail.com")
    @password3 = BCrypt::Password.create("password", cost: 4)
    @merchant_user = User.create(name: "Admin1", password_digest: @password3, role: 2, active: true, address: "88888", city: "Denver", state: "CO", zip: "88888", email: "admin_1@gmail.com")
  end

  it "redirects to the welcome page" do
    visit login_path

    fill_in 'Email', with: "reg_1@gmail.com"
    fill_in 'Password', with: "password"

    click_button('Login')
    click_link("Logout")

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You Have Successfully Logged Out")
  end

  it 'clears the cart' do
    visit login_path

    fill_in 'Email', with: "reg_1@gmail.com"
    fill_in 'Password', with: "password"

    click_button('Login')

    cart = Cart.new({
      '123' => 3,
      '341' => 7,
      '641' => 4
      })

    click_link("Logout")
    expect(cart.contents.empty?).to be true
  end
end
