require "test_helper"

describe SessionsController do
  describe "logging in" do
    it "log in with github as an existing user" do
      user = users(:fetchuser)

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new( mock_auth_hash( user ) )

      get login_path(:github)

      must_redirect_to root_path
      expect(session[:user_id]).must_equal user.id
      expect(flash[:success]).must_equal "Get in, loser. We're going shopping. \u{1F485}"

    end

    it "creates a new user when logging in with valid data" do

      start_count = User.count

      new_user = User.new(username: "new user", uid: 3, provider: :github, email: 'fetch@fetch.com')

      expect(new_user.valid?).must_equal true

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new( mock_auth_hash( new_user ) )

      get login_path(:github)

      must_redirect_to root_path
      expect( User.count ).must_equal start_count + 1
      expect( session[:user_id] ).must_equal User.last.id
    end

    it "does not create a new user when logging in with  invalid data" do
      start_count = User.count

      invalid_new_user = User.new(username: nil, email: nil)

      expect(invalid_new_user.valid?).must_equal false

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new( mock_auth_hash( invalid_new_user ) )

      get login_path(:github)

      must_redirect_to root_path
      expect( session[:user_id] ).must_equal nil
      expect( User.count ).must_equal start_count
    end
  end

  describe "logging out" do
    it "log out with github as an existing user" do
      user = users(:fetchuser)

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new( mock_auth_hash( user ) )

      get login_path(:github)
      delete logout_path(:github)

      must_redirect_to root_path
      expect(session[:user_id]).must_equal nil
      expect(flash[:success]).must_equal "You have been logged out. Been there. Shopped that. \u{1F485}"
    end
  end
end
