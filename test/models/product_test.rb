require "test_helper"

describe Product do

  # Product must belong to a User
  describe 'validations' do
    before do
      # Arrange
      @user = User.first
      @product = Product.new(name: 'Avocado Toast', category: "Lifestyle", quantity: 4, price: 9.99, image: 'https://placekitten.com/200/200')
    end

    it 'is valid when all fields are present' do
      # Act
      @product.user = @user
      result = @product.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'it is invalid if no name for the product is present' do
      # Act
      @product.name = nil
      result = @product.valid?

      # Assert
      expect(result).must_equal false
    end

    it 'it is invalid if another product has the same name' do
      # Act
      @product2 = Product.new(name: 'Avocado Toast', category: "Lifestyle", quantity: 4, price: 9.99, image: 'https://placekitten.com/200/200')
      result = @product2.valid?

      # Assert
      expect(result).must_equal false
    end
    it 'it must have a price' do
      # Act
      @product.price = nil
      result = @product.valid?

      # Assert
      expect(result).must_equal false
    end
    it 'the price must be a number' do
      # Act
      @product.price = "bumblebeetuna"
      result = @product.valid?

      # Assert
      expect(result).must_equal false
    end
    it 'price must be greater than zero' do
      # Act
      @product.price = 0.0
      result = @product.valid?

      # Assert
      expect(result).must_equal false
    end
    it 'price cannot be a negative number' do
      # Act
      @product.price = -9.99
      result = @product.valid?

      # Assert
      expect(result).must_equal false
    end
  end
end
