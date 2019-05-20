require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'relationships' do
    it { should belong_to :item}
    it { should belong_to :user}
  end

  describe 'validations' do
    it { should validate_presence_of :quantity}
    it { should validate_presence_of :price}
    it { should validate_presence_of :fulfilled}
  end
end
