class AddQuantityToCartEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_entries, :quantity, :integer, default: 1
  end
end
