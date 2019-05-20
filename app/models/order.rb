class Order < ApplicationRecord
  belongs_to :user
  validates_presence_of :status
end
