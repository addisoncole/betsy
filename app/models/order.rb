class Order < ApplicationRecord
  belongs_to :user, optional: true
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

  def self.add_product(product, order_id, quantity)
    current_product = CartEntry.find_by(product_id: product.id, order_id: order_id)
    if current_product
      current_product.increment(:quantity, by = quantity)
      if current_product.quantity > product.quantity
        return nil
      end
    else
      current_product = CartEntry.new(product_id: product.id, quantity: quantity, order_id: order_id)
    end
    current_product
  end

  def decrement_products
    self.cart_entries.each do |entry|
      entry.decrement_product
    end
  end

  def mark_paid
    self.update_attribute(:status, :paid)
    self.cart_entries.each do |entry|
      entry.mark_paid
    end
  end

  def total
    total = 0

    self.cart_entries.each do |entry|
      price = Product.find_by(id: entry.product_id).price
      total += entry.quantity * price
    end

    return total
  end

  def order_status
    self.cart_entries.each do |entry|
      unless entry.status == "shipped"
        return "awaiting shipment(s)"
      end
    end

    self.update_attribute(:status, "shipped")
    return "all items in yr order have been shipped, bb!"
  end
end
