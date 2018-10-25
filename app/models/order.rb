class Order < ApplicationRecord
  has_many :cart_entries, dependent: :destroy
  validates :card_number, presence: true, length: { is: 16 }, :numericality => { :only_interger => true }, if: Proc.new { |a| a.status != "pending" }
  validates :card_expiration, presence: true, if: Proc.new { |a| a.status != "pending" }
  validates :CVV, presence: true, length: { is: 3 }, :numericality => { :only_interger => true }, if: Proc.new { |a| a.status != "pending" }
  validates :billing_address, presence: true, if: Proc.new { |a| a.status != "pending" }
  validates :billing_zip_code, presence: true, length: { is: 5 }, :numericality => { :only_interger => true }, if: Proc.new { |a| a.status != "pending" }
  validates :email, presence: true, if: Proc.new { |a| a.status != "pending" }
  validates :shipping_address, presence: true, if: Proc.new { |a| a.status != "pending" }
  validates :status, presence: true
  validates :name, presence: true, if: Proc.new { |a| a.status != "pending" }

  def self.add_product(product, order_id)
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
