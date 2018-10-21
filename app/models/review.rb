class Review < ApplicationRecord
  belongs_to :product
  validates :rating, presence: true, :numericality => { :only_interger => true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5 }
end
