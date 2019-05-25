require 'rails_helper'

# As a visitor or registered user
# When I have added items to my cart
# And I visit my cart ("/cart")
# I see all items I've added to my cart
# And I see a link to empty my cart
# Each item in my cart shows the following information:
# - the name of the item
# - a very small thumbnail image of the item
# - the merchant I'm buying this item from
# - the price of the item
# - my desired quantity of the item
# - a subtotal (price multiplied by quantity)
#
# I also see a grand total of what everything in my cart will cost
RSpec.describe 'As a visitor' do
  context 'As a visitor' do

    it 'When my cart is empty and I visit my cart, It says my cart is empty' do
      visit carts_path

      expect(page).to have_content('Your cart is currently empty.')
      expect(page).to_not have_content('Empty your Cart')
    end

    it 'shows all items in my cart and allows user to clear cart' do
      merchant = create(:user, name: "Merchant", role: 1)
      item_1 = create(:item, user: merchant)

      visit items_path

      within "#item-#{item_1.id}" do
        click_link "Add To Cart"
      end

      click_link('Cart')

      expect(page).to have_content('You must register or login to checkout.')
      expect(page).to have_link('register')
      expect(page).to have_link('login')

      click_link('register')

      expect(current_path).to eq(register_path)

      click_link('Cart')
      click_link('login')

      expect(current_path).to eq(login_path)

    end
  end
end

describe 'As a visitor or a registered user' do
  describe 'when I have items in my cart and view my cart' do

    before :each do
      @merchant = create(:user, name: "Merchant", role: 1)
      @item_1 = create(:item, user: @merchant)
      @item_2 = create(:item, user: @merchant)
      @item_3 = create(:item, user: @merchant)
    end


    it 'shows all items in my cart and allows user to clear cart' do
      visit items_path

      within "#item-#{@item_1.id}" do
        click_button "Add To Cart"
      end

      within "#item-#{@item_2.id}" do
        click_button "Add To Cart"
        click_button "Add To Cart"
      end

      within "#item-#{@item_3.id}" do
        click_button "Add To Cart"
        click_button "Add To Cart"
        click_button "Add To Cart"
      end

      visit carts_path

      within '#cart_total' do
        expect(page).to have_content("$120.00")
      end

      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.user.name)
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(1)
        expect(page).to have_content("$20.00")
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.user.name)
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content(2)
        expect(page).to have_content("$40.00")
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      within "#item-#{@item_3.id}" do
        expect(page).to have_content(@item_3.name)
        expect(page).to have_content(@item_3.user.name)
        expect(page).to have_content(@item_3.price)
        expect(page).to have_content(3)
        expect(page).to have_content("$60.00")
        find "img[src='https://kaaskraam.com/wp-content/uploads/2018/02/Gouda-Belegen.jpg']"
      end

      click_link "Clear Cart"

      expect(page).to_not have_content(@item_1.name)
      expect(page).to_not have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
      expect(page).to have_content("(0)")
    end
  end
end
