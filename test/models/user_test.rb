require "test_helper"

# t.string "name"
# t.string "username"
# t.string "email"
# t.boolean "merchant", default: false


describe User do
  describe 'validations' do
    before do
      @user = User.first
    end

    it "must have an email" do
      @user.must_be :valid?
    end

    it "does not accept data without an email" do
      @user.email = nil

      expect(@user.valid?).must_equal false
      expect ( @user.errors.messages ).must_include :email
    end
  end

  describe "relations" do
    before do
      @user = User.first
    end

    it "has many products" do
      expect(@user.products).must_respond_to :each
    end

    it "has many reviews" do
      expect(@user.reviews).must_respond_to :each
    end
  end

  describe "builds a hash using class method" do
    before do
      @auth_hash = {
        uid: 12345,
        info: {
          name: 'Ultra Fetch',
          email: 'fetch@fetch.com',
          image: 'someimage.jpg'
        }
      }

      @user = User.build_user_hash(@auth_hash)
    end

    it "sets the uid" do
      expect(@user.uid).must_equal(12345)
    end

    it "sets the name and username" do
      expect(@user.name).must_equal('Ultra Fetch')
      expect(@user.username).must_equal('Ultra Fetch')
    end

    it "sets the provider" do
      expect(@user.provider).must_equal('github')
    end

    it "sets the email" do
      expect(@user.email).must_equal('fetch@fetch.com')
    end

    it "sets the image" do
      expect(@user.profile_picture).must_equal('someimage.jpg')
    end

  end
end
