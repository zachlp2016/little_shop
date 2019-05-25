class User < ApplicationRecord
  has_many :items
  has_many :orders

  validates_presence_of :password_digest, :name, :address, :city, :state, :zip

  validates :email, presence: true, uniqueness: true

  has_secure_password

  enum role: ["default", "merchant", "admin"]

  def self.email_string
    pluck(:email)
  end

  def self.all_active_merchants
    where('active=true AND role=1')
  end

  def pending_orders
    binding.pry

  end

end
