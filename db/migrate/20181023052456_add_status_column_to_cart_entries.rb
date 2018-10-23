class AddStatusColumnToCartEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_entries, :status, :string, default: :pending
  end
end
