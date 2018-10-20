require "test_helper"

# t.string "name"
# t.string "username"
# t.string "email"
# t.boolean "merchant", default: false

# Merchant
# Username must be present
# Username must be unique
# Email Address must be present
# Email Address must be unique

describe User do
  describe 'validations' do
    before do
      @user = User.first
    end

    it 'must have a unique username if the user is a merchant' do
    end

    it 'must have a unique email if the user is a merchant' do
    end

    it 'is invalid without a username if the user is a merchant' do
    end

    it 'is invalid without an email if the user is a merchant' do
    end
  end
end
