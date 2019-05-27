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

  def self.top_3_merchants_by_sales
    self.joins(items: :order_items)
        .joins('JOIN orders ON order_items.order_id=orders.id')
        .select('sum(order_items.price * order_items.quantity) AS revenue, users.*')
        .where('users.role=1 AND users.active=true AND orders.status=2')
        .group('users.id')
        .order('revenue desc')
        .limit(3)
  end

  def self.fastest_3_fulfilling_merchants
    self.joins(items: :order_items)
        .joins('JOIN orders ON order_items.order_id=orders.id')
        .where('users.role=1 AND users.active=true AND orders.status=2')
        .select('sum(order_items.updated_at - order_items.created_at) AS fulfillment_time, users.*')
        .group(:id)
        .order('fulfillment_time')
        .limit(3)
  end

  def self.slowest_3_fulfilling_merchants
    self.joins(items: :order_items)
        .joins('JOIN orders ON order_items.order_id=orders.id')
        .where('users.role=1 AND users.active=true AND orders.status=2')
        .select('sum(order_items.updated_at - order_items.created_at) AS fulfillment_time, users.*')
        .group(:id)
        .order('fulfillment_time desc')
        .limit(3)
  end

  def self.top_3_states
    self.joins(items: :order_items)
        .joins('JOIN orders ON order_items.order_id=orders.id')
        .select('count(orders.id), users.state')
        .where('users.role=1 AND orders.status=2')
        .group(:state)
        .order(count: :desc)
  end
end
