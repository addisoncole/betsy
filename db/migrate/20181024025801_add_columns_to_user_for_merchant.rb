class AddColumnsToUserForMerchant < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :store_name, :string
    add_column :users, :store_banner_img, :string
  end
end
