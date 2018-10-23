class ChangeOrdersCardNumberColumnToTypeBigint < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :card_number, :bigint
  end
end
