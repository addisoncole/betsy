class CartEntry < ApplicationRecord
  belongs_to :order
  has_one :product

  validates :quantity, presence: true, :numericality => { :only_interger => true, :greater_than => 0 }

  def decrement_product
      product = Product.find_by(id: self.product_id)
      product.decrement!(:quantity, by = self.quantity)
  end
end
