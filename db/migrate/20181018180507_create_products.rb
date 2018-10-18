class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.name :string
      t.string :category
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
