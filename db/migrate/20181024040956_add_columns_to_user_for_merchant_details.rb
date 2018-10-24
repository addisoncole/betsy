class AddColumnsToUserForMerchantDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :store_location, :string
    add_column :users, :store_description, :string
  end
end
