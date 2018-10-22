class AddProductToCartEntry < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_entries, :product, foreign_key: true
  end
end
