require "test_helper"

describe ProductsController do

  let(:bad_product_id) { Product.first.destroy.id }

  describe "index" do
    it "should get index" do
      # Act
      get products_path

      # Assert
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
    it "can create a product with valid data" do
      # Arrange

      @user = users(:fetchuser)
      perform_login(@user)

      product_hash = {
        product: {
          name: 'Artisanal Coffee',
          category: "Lifestyle",
          quantity: 4,
          price: 9.99,
          image: 'https://placekitten.com/200/200',
          user: @user
        }
      }

      # Assumptions
      test_product = Product.new(product_hash[:product])
      test_product.must_be :valid?, "Product data was invalid. Please come fix this test"

      # Act
      expect {
        post products_path, params: product_hash
      }.must_change('Product.count', +1)

      # Assert
      must_redirect_to product_path(Product.last)
    end

    it "does not create a new product w/ invalid data" do
      # Arrange

      @user = users(:fetchuser)
      perform_login(@user)

      product_hash = {
        product: {
          name: '',
          category: "Lifestyle",
          quantity: 4,
          price: 9.99,
          image: 'https://placekitten.com/200/200',
          user: @user
        }
      }

      # Assumptions
      test_product = Product.new(product_hash[:product])

      # Act
      expect {
        post products_path, params: product_hash
      }.wont_change('Product.count')

      # Assert
      must_respond_with :bad_request
    end

    describe "show" do

      it "should respond with success for showing an existing book" do
        # Arrange
        @product = products(:avocadotoast)

        # Act
        get products_path(@product.id)

        # Assert
        must_respond_with :success
      end

      it "should respond with not found for showing a non-existing product" do
        # Arrange
        @product = products(:avocadotoast)
        id = @product.id

        get product_path(id)
        must_respond_with :success


        @product.destroy

        # Act
        get product_path(id)

        # Assert
        must_respond_with :missing
      end

    end

    describe "edit" do
      it "responds with success for an existing product" do
        get edit_product_path(Product.first)
        must_respond_with :success
      end

      it "responds with not_found for a product that doesn't exist" do
        @product = products(:avocadotoast)
        id = @product.id

        @product.destroy

        get edit_product_path(id)
        must_respond_with :not_found
      end
    end

    describe "update" do
      it "responds with success for an updating existing product with valid information" do
        @user = users(:fetchuser)
        perform_login(@user)

        @product = products(:swisscheeseplant)
        updated_name = "Addy waz here"
        put product_path(@product.id), params: {
          product: {
            name: updated_name
          }
        }
        @product.reload
        assert_equal updated_name, @product.name
      end

      it "responds with bad_request for a product that is invalid" do
        @user = users(:fetchuser)
        perform_login(@user)

        @product = products(:swisscheeseplant)
        updated_name = ""
        put product_path(@product.id), params: {
          product: {
            name: updated_name
          }
        }
        must_respond_with :bad_request
      end

    end

    describe "destroy" do
      it "can destroy an existing product" do
        # Arrange
        @product = products(:swisscheeseplant)
        expect(@product.user_id).must_equal users(:fetchuser).id

        # Act
        expect {
          delete product_path(@product.id)
        }.must_change('Product.count', -1)

        # Assert
        must_respond_with :redirect
        must_redirect_to products_path
      end

      it "responds with not_found if the product doesn't exist" do
        id = bad_product_id
        expect {
          delete product_path(id)
        }.wont_change('Product.count')

        must_respond_with :not_found
      end
    end

    describe "review" do
      it "checks the user is logged in" do

      end
    end

  end
end
