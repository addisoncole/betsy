require "test_helper"

describe UsersController do
  describe "index" do
    it "should get all index" do
      get users_path

      must_respond_with :success
    end
  end

  describe "new" do
    it "can get the new page" do
      get new_product_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can creates a user with valid data but does not save it yet" do
      # Arrange
      user_data = {
        user: {
          username: "name",
          email: "name@name.com"
        }
      }

      # Assumptions
      test_user = User.new(user_data[:user])
      test_user.must_be :valid?, "User data was invalid. Please come fix this test"

      # Act
      expect {
        post users_path, params: user_data
      }.wont_change('User.count')

      # Assert
      must_respond_with :success
    end

    it "does not create a new book w/ invalid data" do
      user_data = {
        user: {
          username: "name",
          email: nil
        }
      }

      # Assumptions
      test_user = User.new(user_data[:user])
      test_user.wont_be :valid?, "User data was not invalid. Please come fix this test"

      # Act
      expect {
        post users_path, params: user_data
      }.wont_change('User.count')

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "should respond with success for showing an existing logged in user/non-merchant" do
      user_data = {
          name: 'name',
          email: 'name@name.com',
          uid: 9876,
          provider: 'github'
      }
      user = User.create!(user_data)
# binding.pry
      get user_path(user.id)

      must_respond_with :success
    end

    it "should respond with not found for showing a non-existing logged in user/non-merchant" do
      user_data = {
          name: 'name',
          email: 'name@name.com',
          uid: 9876,
          provider: 'github',
          merchant: false
      }
      user = User.create!(user_data)
      user.destroy

      get user_path(user.id)

      must_redirect_to users_path
    end
  end

  describe "update" do
    it "updates existing logged in user data" do
      user = users(:fetchuser)
      perform_login(user)

      update_data = {
        user: {
          email: 'hello@gmail.com'
        }
      }
# binding.pry
      patch user_path(user.id), params: update_data


      expect(User.find_by(id: user.id).email).must_equal 'hello@gmail.com'
      expect(flash[:success]).must_equal "Successfully updated, you go Glen Coco! \u{1F389}"
    end
  end

  describe "userdash" do
    it "assigns orders and products of that user" do
      user = users(:fetchuser)
      perform_login(user)

      expect{
        get userdash_path, params: user
      }

      must_respond_with :found
    end

    it "redirects if user not found" do
      user = nil

      get userdash_path, params: user

      must_redirect_to root_path
    end
  end

  describe "manage orders" do
    it "check for valid user" do
      user = users(:fetchuser)
      perform_login(user)

      get manage_orders_path, params: user

      must_respond_with :success
    end

    it "redirects to root path if user not found" do
      user = nil

      get manage_orders_path, params: user

      must_redirect_to root_path
    end

    it "checks for order status defaults " do
      user = users(:fetchuser)
      perform_login(user)

      status_data = {
        status: ""
      }

      get manage_orders_path, params: status_data

      must_respond_with :success
    end

    it "checks that status is pending" do

      user = users(:fetchuser)
      perform_login(user)

      status_data = {
        status: "pending"
      }

      get manage_orders_path, params: status_data

      must_respond_with :success
    end

    it "checks that status is shipped" do

      user = users(:fetchuser)
      perform_login(user)

      status_data = {
        status: "shippedu"
      }

      get manage_orders_path, params: status_data

      must_respond_with :success
    end
  end
end
