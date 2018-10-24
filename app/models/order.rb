class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_entries, dependent: :destroy

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
      unless entry.status == :shipped
        return "awaiting shipment(s)"
      end
    end

    return "all items in yr order have been shipped, bb!"
  end
end
