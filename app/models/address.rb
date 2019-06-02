class Address < ApplicationRecord

  belongs_to :user

  validates :nickname, presence: true, uniqueness: true
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
end
