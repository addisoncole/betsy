class User < ApplicationRecord
  has_many :products
  has_many :reviews
  has_many :orders
  validates :email, presence: true

  def self.build_user_hash(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = 'github'
    user.name = auth_hash[:info][:name]
    user.email = auth_hash[:info][:email]
    # Typically create a shorter username
    # for use in URLs, something like:
    # Ultra Fetch -> ultra-fetch
    user.username = auth_hash[:info][:name]
    user.profile_picture = auth_hash[:info][:image]

    return user
  end

  def merchant_orders
    my_products = Product.where(user_id: self.id)
    entries = CartEntry.where(product_id: my_products)
    order_ids = []

    entries.each do |entry|
      order_ids << entry.order_id
    end

    merchant_orders = Order.where(id: order_ids, status: :paid)
    return merchant_orders
  end
end
