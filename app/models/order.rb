class Order < ApplicationRecord
  has_many :cart_entries, dependent: :destroy
  validate :card_number, :presence, if: Proc.new { |a| a.status == "paid" }
  validates :card_number, :numericality => { :only_interger => true, :must_equal => 16 }
  validate :card_expiration, :presence, if: Proc.new { |a| a.status == "paid" }
  validate :CVV, :presence, if: Proc.new { |a| a.status == "paid" }
  validates :CVV, :numericality => { :only_interger => true, :must_equal => 3 }
  validate :billing_address, :presence, if: Proc.new { |a| a.status == "paid" }
  validate :billing_zip_code, :presence, if: Proc.new { |a| a.status == "paid" }
  validates :billing_zip_code, :numericality => { :only_interger => true, :must_equal => 5 }
  validate :email, :presence, if: Proc.new { |a| a.status == "paid" }
  validate :shipping_address, :presence, if: Proc.new { |a| a.status == "paid" }

  def add_product(product, order_id)
    current_product = CartEntry.find_by(product_id: product.id, order_id: order_id)
    if current_product
      current_product.increment(:quantity)
    else
      current_product = CartEntry.new(product_id: product.id)
    end
    current_product
  end

  def decrement_products
    self.cart_entries.each do |entry|
      entry.decrement_product
    end
  end
end
