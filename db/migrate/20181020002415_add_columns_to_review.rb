class AddColumnsToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :rating, :integer
    add_column :reviews, :comment, :string
  end
end
