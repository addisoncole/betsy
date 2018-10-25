class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_entries, dependent: :destroy

  def add_product(product, order_id, quantity)
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
      unless entry.status == :shipped
        return "awaiting shipment(s)"
      end
    end

    self.update_attribute(:status, :shipped)
    return "all items in yr order have been shipped, bb!"
  end
end
