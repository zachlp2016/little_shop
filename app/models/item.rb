class Item < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :active, :price, :description, :image, :inventory
end
