class ChangeNameOfImageUrlColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :image_url, :image
  end
end
