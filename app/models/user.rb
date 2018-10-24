class User < ApplicationRecord
  has_many :products, dependent: :nullify
  has_many :reviews
  has_many :orders
  validates :email, presence: true

  def self.build_user_hash(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = 'github'
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.username = auth_hash['info']['name']
    user.profile_picture = auth_hash['info']['image']

    # Note that the user has not been saved
    return user
  end

end
