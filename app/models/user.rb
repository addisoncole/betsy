class User < ApplicationRecord
  has_many :products
  has_many :reviews
  validates :email, presence: true

  def self.build_user_hash(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = 'github'
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']

    # Note that the user has not been saved
    return user
  end
end
