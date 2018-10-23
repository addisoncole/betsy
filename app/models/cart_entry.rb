class CartEntry < ApplicationRecord
  belongs_to :order
  has_one :product
  validates :order_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true, :numericality => { :only_interger => true, :greater_than => 0 }
end
