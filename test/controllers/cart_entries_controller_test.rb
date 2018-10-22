require "test_helper"

describe CartEntriesController do
  describe "create" do
    it "can create a book with valid data" do

      user = users(:fetchuser)
      perform_login(user)

      session[:user_id].must_equal user.id
      # Arrange
      cart_entry_data = {
        cart_entry: {
          order_id: orders(:one).id,
          quantity: 1
        }
      }

      # Assumptions
      test_entry = CartEntry.new(cart_entry_data[:cart_entry])
      test_entry.must_be :valid?, "Cart entry data was invalid. Please come fix this test"

      # Act
      expect {
        post product_cart_entries_path(products(:avocadotoast).id), params: cart_entry_data
      }.must_change('CartEntry.count', +1)

      # Assert
      must_redirect_to root_path
    end
  end
end
