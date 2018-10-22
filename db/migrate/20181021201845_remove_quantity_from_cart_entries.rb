class RemoveQuantityFromCartEntries < ActiveRecord::Migration[5.2]
  def change
    remove_column :cart_entries, :quantity
  end
end
