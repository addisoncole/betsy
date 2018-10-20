class AddColumnToCartEntry < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_entries, :quantity, :integer
  end
end
