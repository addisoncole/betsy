class CreateCartEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_entries do |t|

      t.timestamps
    end
  end
end
