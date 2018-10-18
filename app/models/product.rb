class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :quantity, presence: true, :numericality => { :only_interger => true, :greater_than_or_equal_to => 0 }
end
