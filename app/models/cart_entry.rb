class CartEntry < ApplicationRecord
  belongs_to :order
  has_one :product

  validates :quantity, presence: true, :numericality => { :only_interger => true, :greater_than => 0 }
  validates :order_id, presence: true
end
