class AddOrderToCartEntry < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_entries, :order, foreign_key: true
  end
end
