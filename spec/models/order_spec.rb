require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :items}
  end

  describe 'validations' do
    it { should validate_presence_of :status }
  end
end
