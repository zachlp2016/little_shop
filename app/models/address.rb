class Address < ApplicationRecord

  belongs_to :user

  validates_presence_of :nickname
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
end
