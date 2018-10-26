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

#     it "returns array of products that has the same category" do
#       first_product = products(:swisscheeseplant)
#       sec_product = products(:soupplant)
#
#       expect {
#         get products_path, params: {category: 'Plants'}
#       }
# binding.pry
# # @controller.view_assigns[]
#       expect(assigns(:title)).must_equal 'plants'
#       expect(assigns(:products).count).must_equal 2
#     end
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
        product = products(:avocadotoast)

        # Act
        get products_path(product.id)

        # Assert
        must_respond_with :success
      end

      it "should respond with not found for showing a non-existing product" do

        id = bad_product_id

        get product_path(id)

        # Assert
        must_respond_with :missing
      end

    end

    describe "edit" do
      it "responds with success for an existing product" do
        get edit_product_path(Product.first)
        must_respond_with :found
      end

      it "responds with not_found for a product that doesn't exist" do

        id = bad_product_id

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
        user = users(:fetchuser)
        perform_login(user)

        session[:user_id] = user.id
        product = products(:swisscheeseplant)
        expect(product.user_id).must_equal users(:fetchuser).id

        # Act
        expect {
          delete product_path(product.id)
        }.must_change('Product.count', -1)

        # Assert
        must_respond_with :redirect
        must_redirect_to products_path
        expect(flash[:success]).must_equal "Successfully destroyed #{product.name} \u{1F4A5}	"
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
        user = users(:new_user)
        perform_login(user)

        session[:user_id] = user.id
        product = products(:avocadotoast)

        review_hash = {
            rating: 4,
            comment: "new comment"
        }


          expect {
            post review_path(product.id), params: review_hash
          }.must_change('Review.count', 1)

          must_respond_with :redirect
          expect(flash[:success]).must_equal "Successfully gave your thoughts && prayers! You go Glen Coco! \u{1F389}"
          must_redirect_to product_path(product.reviews.last.product_id)
      end

      it "does not save review for user that added that product" do
        user = users(:fetchuser)
        perform_login(user)

        session[:user_id] = user.id
        product = products(:avocadotoast)

        review_hash = {
            rating: 4,
            comment: "new comment"
        }

          expect {
            post review_path(product.id), params: review_hash
          }.wont_change('Review.count')

          must_respond_with :redirect
          expect(flash[:error]).must_equal "Errawr. \u{1F996} Cannot review own product, loser."
          must_redirect_to product_path(product.reviews.first.product_id)
      end

      it "does not save review if you are not logged in" do
        product = products(:avocadotoast)

        review_hash = {
            rating: 4,
            comment: "new comment"
        }

          expect {
            post review_path(product.id), params: review_hash
          }.wont_change('Review.count')

          must_respond_with :redirect
          expect(flash[:error]).must_equal "Members Only"
          must_redirect_to product_path(product.id)
      end
    end

  end
end
