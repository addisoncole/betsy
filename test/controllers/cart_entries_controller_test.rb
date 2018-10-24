require "test_helper"
require 'pry'

describe CartEntriesController do
  describe "create" do
    before do
      user = users(:fetchuser)
      perform_login(user)

      session[:user_id] = user.id

      # Arrange
      @cart_entry_data = {
        product_id: products(:avocadotoast).id,
        cart_entry: {
          order_id: orders(:persons_order).id,
          product_id: products(:avocadotoast).id,
          quantity: 1,
          status: "pending"
        }
      }
    end

    it "creates new cart entry with valid data" do

      # Assumptions
      test_entry = CartEntry.new(@cart_entry_data[:cart_entry])
      test_entry.must_be :valid?, "Entry data was invalid. Please come fix this test"

      # Act
      expect {
        post cart_entries_path(products(:avocadotoast).id), params: @cart_entry_data
      }.must_change('CartEntry.count', +1)

      # Assert
      must_redirect_to root_path
    end

    it "does not create a new cart entry w/ invalid data" do

      @cart_entry_data[:cart_entry][:quantity] = nil

      CartEntry.new(@cart_entry_data[:cart_entry]).wont_be :valid?, "Entry data wasn't invalid. Please come fix this test"

      # Act
      expect {
        post cart_entries_path(products(:avocadotoast).id), params: @cart_entry_data
      }.wont_change('CartEntry.count')

      # Assert
      must_redirect_to product_path(products(:avocadotoast).id)
    end

    it "does not create a new entry if entry's quantity is greater than product quantity" do
      CartEntry.new(@cart_entry_data[:cart_entry])
      post cart_entries_path(products(:avocadotoast).id), params: @cart_entry_data

      @cart_entry_data[:cart_entry][:quantity] = 20

      CartEntry.new(@cart_entry_data[:cart_entry]).must_be :valid?, "Entry data wasn't valid. Please come fix this test"

      expect {
        post cart_entries_path(products(:avocadotoast).id), params: @cart_entry_data
      }.wont_change('CartEntry.count')

      # Assert
      must_redirect_to product_path(products(:avocadotoast).id)
    end
  end

  describe "update" do
    
  end
end
