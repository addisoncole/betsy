class AddDefaultValueToCartEntryStatus < ActiveRecord::Migration[5.2]
  def change
    change_column :cart_entries, :status, :string, default: :pending
  end
end
