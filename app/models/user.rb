class User < ApplicationRecord
  has_many :items
  has_many :orders

  validates_presence_of :password_digest, :name, :address, :city, :state, :zip

  validates :email, presence: true, uniqueness: true

  has_secure_password

  enum role: ["default", "merchant", "admin"]

  def best_customer_items
    User.select("users.*, sum(order_items.quantity) AS total_ordered")
      .joins(orders: :items)
      .where("orders.status = 2 AND items.user_id = #{self.id} ")
      .group("users.id")
      .order("total_ordered DESC, users.id ASC")
      .limit(1)
  end

  def best_customer_orders
    require 'pry'; binding.pry
    User.joins(orders: :items).where("orders.status = 2 AND items.user_id = #{self.id} ").distinct("users.id, orders.id").select("users.*, count(orders.id) AS total_orders").group("users.id").order("total_orders DESC, users.id ASC").limit(1)
    User.joins(orders: :items).where("orders.status = 2 AND items.user_id = #{self.id} ").distinct("users.id").select("users.*, count(orders.id) AS total_orders").group("users.id").order("total_orders DESC, users.id ASC").limit(1)
  end

  def top_3_city_state
    self.items
        .joins(:orders)
        .joins("JOIN users ON users.id = orders.user_id")
        .where("orders.status=2")
        .select("count(order_items.id), users.state, users.city")
        .group("users.state")
        .group("users.city")
        .order("count desc")
        .limit(3)
  end
 
 def top_3_states
    User.select("users.state, sum(order_items.quantity) AS total_ordered")
    .joins(orders: :items)
    .where("orders.status = 2 AND items.user_id = #{self.id} ")
    .group("users.state")
    .order("total_ordered DESC")
    .limit(3)
  end

  def top_items_sold(limit)
    Item.joins(:user, :orders)
        .where("orders.status = 2 AND items.user_id = #{self.id}")
        .select("items.*, sum(order_items.quantity) AS total_ordered")
        .group("items.id")
        .order('total_ordered DESC')
        .limit(limit)
  end

  def items_sold
    User.joins(items: :orders)
        .where("orders.status = 2 AND items.user_id = #{self.id}")
        .select("users.*, sum(order_items.quantity) AS total_ordered, sum(items.inventory) AS total_inventory")
        .group("users.id")
        .first
        .total_ordered
  end

  def total_items_count
    items.sum(:inventory) + self.items_sold
  end

  def items_sold_percentage
    stats = User.joins(items: :orders)
        .where("orders.status = 2 AND items.user_id = #{self.id}")
        .select("users.*, sum(order_items.quantity) AS total_ordered, sum(items.inventory) AS total_inventory")
        .group("users.id")
    ordered = stats.first.total_ordered
    inventory = stats.first.total_inventory + stats.first.total_ordered
    ordered / inventory
  end

  def self.email_string
    pluck(:email)
  end

  def self.all_active_merchants
    where('active=true AND role=1')
  end

  def pending_orders
    Order.joins(:items).
          where("items.user_id = #{self.id} AND orders.status = 1").
          distinct(:orders)
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
        .where("users.role=1 AND users.active=true AND orders.status=2")
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
        .select('count(orders.*), users.state')
        .where('orders.status=2 AND users.role=1')
        .group(:state)
        .order(count: :desc)
        .limit(3)
  end

  def self.top_3_cities
    self.joins(items: :order_items)
        .joins('JOIN orders ON order_items.order_id=orders.id')
        .select('count(orders.*), users.state, users.city')
        .where('orders.status=2 AND users.role=1')
        .group(:state)
        .group(:city)
        .order(count: :desc)
        .limit(3)
  end
end
