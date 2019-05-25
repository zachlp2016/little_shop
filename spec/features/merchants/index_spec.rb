require 'rails_helper'

RSpec.describe 'when visiting the merchants index page' do

  describe 'all merchants are visible' do

    describe 'who are active' do

      before :each do
        @merchant_1 = create(:user, role: 1, created_at: Date.new(1995, 5, 3))
        @merchant_2 = create(:user, role: 1, created_at: Date.new(2015, 12, 8))
        @merchant_3 = create(:user, role: 1, created_at: Date.new(2002, 9, 10))
        @merchant_4 = create(:user, role: 1, created_at: Date.new(1955, 3, 21))
        @merchant_5 = create(:user, role: 1, active: false)
        @merchant_6 = create(:user, role: 1, active: false)
        user = create(:user)
      end

      it 'shows merchant name, city, state, date registered' do
        visit merchants_path

        within "#merchant-#{@merchant_1.id}" do
          expect(page).to have_content(@merchant_1.name)
          expect(page).to have_content(@merchant_1.city)
          expect(page).to have_content(@merchant_1.state)
          expect(page).to have_content(@merchant_1.created_at.strftime("%B %d, %Y"))
        end

        within "#merchant-#{@merchant_2.id}" do
          expect(page).to have_content(@merchant_2.name)
          expect(page).to have_content(@merchant_2.city)
          expect(page).to have_content(@merchant_2.state)
          expect(page).to have_content(@merchant_2.created_at.strftime("%B %d, %Y"))
        end

        within "#merchant-#{@merchant_3.id}" do
          expect(page).to have_content(@merchant_3.name)
          expect(page).to have_content(@merchant_3.city)
          expect(page).to have_content(@merchant_3.state)
          expect(page).to have_content(@merchant_3.created_at.strftime("%B %d, %Y"))
        end

        within "#merchant-#{@merchant_4.id}" do
          expect(page).to have_content(@merchant_4.name)
          expect(page).to have_content(@merchant_4.city)
          expect(page).to have_content(@merchant_4.state)
          expect(page).to have_content(@merchant_4.created_at.strftime("%B %d, %Y"))
        end

        expect(page).to_not have_content(@merchant_5.name)
        expect(page).to_not have_content(@merchant_6.name)
      end

    end

  end
end
