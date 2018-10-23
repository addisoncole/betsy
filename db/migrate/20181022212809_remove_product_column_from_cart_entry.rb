class RemoveProductColumnFromCartEntry < ActiveRecord::Migration[5.2]
  def change
    remove_column :cart_entries, :product_id
  end
end
