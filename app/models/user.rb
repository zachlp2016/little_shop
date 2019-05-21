class User < ApplicationRecord
  has_many :items
  has_many :orders

  validates_presence_of :password_digest, :role, :active, :name, :address, :city, :state, :zip
  validates :email, presence: true, uniqueness: true

  has_secure_password
end
