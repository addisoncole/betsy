class Order < ApplicationRecord
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
end
