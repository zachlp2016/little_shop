require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :orders }
  end

  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :active}
    it { should validate_presence_of :price}
    it { should validate_presence_of :description}
    it { should validate_presence_of :image}
    it { should validate_presence_of :inventory}
  end
end
