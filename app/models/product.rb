class Product < ApplicationRecord
  before_destroy :not_referenced_by_any_cart_entry
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, :numericality => {  :greater_than => 0 }
  validates :quantity, presence: true, :numericality => { :only_interger => true, :greater_than_or_equal_to => 0 }
  belongs_to :user
<<<<<<< HEAD
  belongs_to :cart_entry

  private

  def not_referenced_by_any_cart_entry
    unless cart_entries.empty?
      errors.add(:base, "Cart items present")
      throw :abort
    end
  end
=======
  has_many :reviews
>>>>>>> f449d52b4e9962e442086da04e500b7f82e18188
end
