class User < ApplicationRecord
  validates_presence_of :password_digest, :role, :active, :name, :address, :city, :state, :zip
  validates :email, presence: true, uniqueness: true
end
