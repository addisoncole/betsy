class RemoveCartentryQuantityDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :cart_entries, :quantity, nil
  end
end
