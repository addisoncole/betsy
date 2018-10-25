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
    before do
      user = users(:fetchuser)
      perform_login(user)

      session[:user_id] = user.id

      # Arrange
      @cart_entry_data = {
        product_id: products(:swisscheeseplant).id,
        cart_entry: {
          order_id: orders(:persons_order).id,
          product_id: products(:swisscheeseplant).id,
          quantity: 1,
          status: "pending"
        }
      }

      @test_entry = CartEntry.create!(@cart_entry_data[:cart_entry])
    end

    it "updates quantity" do
      # ARRANGE
      new_quantity = 5
      @test_entry.quantity = new_quantity
      @test_entry.must_be :valid?, "Entry data was invalid. Please come fix this test"

      # ACT
      patch cart_entry_path(@test_entry), params: {cart_entry: {quantity: new_quantity}}

      # ASSERT
      @test_entry.reload

      expect(@test_entry.quantity).must_equal new_quantity
      must_redirect_to order_path(@test_entry.order_id)
    end

    it "does not update if quantity is invalid" do
      @test_entry.must_be :valid?, "Entry data was invalid. Please come fix this test"

      new_quantity = 0
      @test_entry.quantity = new_quantity
      @test_entry.wont_be :valid?, "Entry data was not invalid. Please come fix this test"

      patch cart_entry_path(@test_entry), params: {cart_entry: {quantity: new_quantity}}

      @test_entry.reload
      expect(@test_entry.quantity).must_equal 1
      must_redirect_to order_path(@test_entry.order_id)
    end

    it "does not update another user\'s cart entry" do
      new_entry_data = {
        product_id: products(:swisscheeseplant).id,
        cart_entry: {
          order_id: orders(:new_order).id,
          product_id: products(:swisscheeseplant).id,
          quantity: 1,
          status: "pending"
        }
      }

      new_entry = CartEntry.create!(new_entry_data[:cart_entry])

      new_quantity = 5
      new_entry.quantity = new_quantity

      patch cart_entry_path(@test_entry), params: {cart_entry: {quantity: new_quantity}}

      @test_entry.reload
      expect(@test_entry.quantity).must_equal 1
      must_redirect_to order_path(@test_entry.order_id)
    end
  end

  describe "destroy" do
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

    it "deletes one cart entry in order page" do
      #ARRANGE
      test_entry = CartEntry.create!(@cart_entry_data[:cart_entry])
      test_entry.must_be :valid?, "Entry data was invalid. Please come fix this test"

      #ACT
      expect {
        delete cart_entry_path(test_entry.id)
      }.must_change('CartEntry.count', -1)

      #ASSERT
      must_respond_with :redirect
      must_redirect_to order_path(test_entry.order_id)
    end
  end
end
