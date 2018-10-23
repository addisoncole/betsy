class RenameOrderAddressColumnToBillingAddress < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :address, :billing_address
  end
end
