require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :orders }
  end

  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :price}
    it { should validate_presence_of :description}
    it { should validate_presence_of :image}
    it { should validate_presence_of :inventory}
  end

  before :each do
    merchant_1 = create(:user)
    merchant_2 = create(:user)
    @item_1 = create(:item, user: merchant_1)
    @item_2 = create(:item, user: merchant_1)
    @item_3 = create(:item, user: merchant_1)
    @item_4 = create(:item, user: merchant_2)
    @item_5 = create(:item, user: merchant_2, active: false)
    @item_6 = create(:item, user: merchant_2, active: false)
  end

  describe 'class methods' do

    it '.all_active' do
      active = [@item_1, @item_2, @item_3, @item_4]
      non_active = [@item_5, @item_6]

      Item.all_active.each do |item|
        expect(active.include?(item)).to be true
        expect(non_active.include?(item)).to be false
      end

    end

  end
  
end
