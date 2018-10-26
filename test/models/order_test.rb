require "test_helper"
require 'pry'

describe Order do
  describe "validations" do
    it "is valid when status is pending and no fields are present" do
      @order = Order.new(status: "pending")
      @order.valid?.must_equal true
    end
    it "is valid when status is paid and all fields are present" do
      @order = Order.new(status: "paid", card_number: 2222222222222222, card_expiration: "10/12", CVV: 123, billing_zip_code: 12345, shipping_address: "fff", billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal true
    end
    it "is not valid when status is paid and no fields are present" do
      @order = Order.new(status: "paid", card_number: nil, card_expiration: nil, CVV: nil, billing_zip_code: nil, shipping_address: nil, billing_address: nil, email: nil, name: nil)
      @order.valid?.must_equal false
    end
    it "requires a card number when status is paid" do
      @order = Order.new(status: "paid", card_expiration: "10/12", CVV: 123, billing_zip_code: 12345, shipping_address: "fff", billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :card_number
    end
    it "requires a card expiration when status is paid" do
      @order = Order.new(status: "paid", card_number: 2222222222222222, CVV: 123, billing_zip_code: 12345, shipping_address: "fff", billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :card_expiration
    end
    it "requires a CVV when status is paid" do
      @order = Order.new(status: "paid", card_number: 2222222222222222, card_expiration: "10/12", billing_zip_code: 12345, shipping_address: "fff", billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :CVV
    end
    it "requires a billing zip code when status is paid" do
      @order = Order.new(status: "paid", card_number: 2222222222222222, card_expiration: "10/12", CVV: 123, shipping_address: "fff", billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :billing_zip_code
    end
    it "requires a shipping_address when status is paid" do
      @order = Order.new(status: "paid", card_number: 2222222222222222, card_expiration: "10/12", CVV: 123, billing_zip_code: 12345, billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :shipping_address
    end
    it "requires a billing_address when status is paid" do
      @order = Order.new(status: "paid", card_number: 2222222222222222, card_expiration: "10/12", CVV: 123, billing_zip_code: 12345, shipping_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :billing_address
    end
    it "requires an email when status is paid" do
      @order = Order.new(status: "paid", card_number: 2222222222222222, card_expiration: "10/12", CVV: 123, billing_zip_code: 12345, shipping_address: "fff", billing_address: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :email
    end
    it "requires a name when status is paid" do
      @order = Order.new(status: "paid", card_number: 2222222222222222, card_expiration: "10/12", CVV: 123, billing_zip_code: 12345, shipping_address: "fff", billing_address: "fff", email: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :name
    end
    it "card number must be of type bigint" do
      @order = Order.new(status: "paid", card_number: "asdfghjklasdfghj", card_expiration: "10/12", CVV: 123, billing_zip_code: 12345, shipping_address: "fff", billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :card_number
    end
    it "card number must be 16 digits" do
      @order = Order.new(status: "paid", card_number: 12345678901, card_expiration: "10/12", CVV: 123, billing_zip_code: 12345, shipping_address: "fff", billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :card_number
    end
    it "CVV must be of type integer" do
      @order = Order.new(status: "paid", card_number: 2222222222222222, card_expiration: "10/12", CVV: "asd", billing_zip_code: 12345, shipping_address: "fff", billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :CVV
    end
    it "CVV must be 3 digits" do
      @order = Order.new(status: "paid", card_number: 2222222222222222, card_expiration: "10/12", CVV: 1234, billing_zip_code: 12345, shipping_address: "fff", billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :CVV
    end
    it "billing_zip_code must be of type integer" do
      @order = Order.new(status: "paid", card_number: 2222222222222222, card_expiration: "10/12", CVV: 123, billing_zip_code: "string", shipping_address: "fff", billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :billing_zip_code
    end
    it "billing_zip_code must 5 digits" do
      @order = Order.new(status: "paid", card_number: 2222222222222222, card_expiration: "10/12", CVV: 123, billing_zip_code: 123456, shipping_address: "fff", billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal false
      @order.errors.messages.must_include :billing_zip_code
    end
  end
  describe 'add product method' do
    it 'returns current_product of type cart_entry' do
      current_product = Order.add_product(products(:swisscheeseplant), orders(:persons_order).id, 1)
      current_product.must_be_kind_of CartEntry
    end
    it 'returns nil if quantity is larger than available quantity' do
      current_product = Order.add_product(products(:swisscheeseplant), orders(:persons_order).id, 11)
      current_product.must_equal nil
    end
    it 'creates a new cart entry if the product does not exist in the current order' do
      product = Product.new(name: 'Artisanal Coffee', category: "Lifestyle", quantity: 4, price: 99.99)
      order = Order.new(status: "pending")
      current_product = Order.add_product(product, order.id, 3)
      current_product.must_be_kind_of CartEntry
    end
  end
  # describe 'decrement_product method' do
  #   it 'decrements product quantity by quantity in order' do
  #     Order.add_product(products(:swisscheeseplant), orders(:persons_order).id, 10)
  #     # binding.pry
  #     cart_entries = Order.decrement_products
  #     expect(cart_entries.product.quantity).must_equal 0
  #   end
  # end
end

##THESE ARE THE METHODS FOR THE DECREMENT PRODUCT TEST
# def decrement_products
#   self.cart_entries.each do |entry|
#     entry.decrement_product
#   end
# end

##THIS IS THE ONE THAT 'DECREMENT_PRODUCTS' REFERENCES, LOCATED IN THE CART ENTRY MODEL
# def decrement_product
#     product = Product.find_by(id: self.product_id)
#     product.decrement!(:quantity, by = self.quantity)
# end
