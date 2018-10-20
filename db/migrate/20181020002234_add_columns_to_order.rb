class AddColumnsToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :card_number, :integer
    add_column :orders, :card_expiration, :string
    add_column :orders, :CVV, :integer
    add_column :orders, :billing_zip_code, :integer
    add_column :orders, :shipping_address, :string
    add_column :orders, :email, :string
    add_column :orders, :address, :string
  end
end
