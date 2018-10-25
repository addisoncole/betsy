class RemoveDefaultFromCartEntriesStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :cart_entries, :status, nil
  end
end
