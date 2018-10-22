class Order < ApplicationRecord
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
end
