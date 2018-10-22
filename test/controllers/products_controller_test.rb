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

    # it "does not create a new product w/ invalid data" do
    #   # Arrange
    #   @user = User.first
    #   product_hash = {product: { name: 'Artisanal Coffee', category: "Lifestyle", quantity: 4, price: 9.99, image: 'https://placekitten.com/200/200', user_id: @user.id }}
    #
    #   # Assumptions
    #   Book.new(book_data[:book]).wont_be :valid?, "Book data wasn't invalid. Please come fix this test"
    #
    #   # Act
    #   expect {
    #     post(books_path, params: book_data)
    #   }.wont_change('Book.count')
    #
    #   # Assert
    #   must_respond_with :bad_request
    # end
  # end

  # describe "show" do

  # it "should respond with success for showing an existing book" do
  #   # Arrange
  #   existing_book = books(:poodr)
  #
  #   # Act
  #   get book_path(existing_book.id)
  #
  #   # Assert
  #   must_respond_with :success
  # end
  #
  # it "should respond with not found for showing a non-existing book" do
  #   # Arrange
  #   # book = books(:poodr)
  #   # id = book.id
  #
  #   # get book_path(id)
  #   # must_respond_with :success
  #   #
  #   #
  #   # book.destroy
  #
  #   # Act
  #   get book_path(bad_book_id)
  #
  #   # Assert
  #   must_respond_with :missing
  # end

# end

# describe "edit" do
#   it "responds with success for an existing book" do
#     get edit_book_path(Book.first)
#     must_respond_with :success
#   end
#
#   it "responds with not_found for a book that D.N.E." do
#     get edit_book_path(bad_book_id)
#     must_respond_with :not_found
#   end
# end
#
# describe "update" do
# end
#
#
# describe "destroy" do
#   it "can destroy an existing book" do
#     # Arrange
#     book = books(:poodr)
#     # before_book_count = Book.count
#
#     # Act
#     expect {
#       delete book_path(book)
#     }.must_change('puts "inside the must_change argument"; Book.count', -1)
#
#     # Assert
#     must_respond_with :redirect
#     must_redirect_to books_path
#
#     # expect(Book.count).must_equal(
#     #   before_book_count - 1,
#     #   "book count did not decrease"
#     # )
#   end
#
#   it "responds with not_found if the book doesn't exist" do
#     id = bad_book_id
#     expect {
#       delete book_path(id)
#     }.wont_change('Book.count')
#
#     must_respond_with :not_found
#   end
# end



end
end
