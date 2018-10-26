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
    it 'finds a cart entry given a product id and order id' do
      current_product = Order.add_product(products(:avocadotoast), orders(:persons_order).id)
      current_product.must_equal cart_entries(:entry)
    end
    it 'returns current_product of type cart_entry' do
      current_product = Order.add_product(products(:swisscheeseplant), orders(:persons_order).id)
      current_product.must_be_kind_of CartEntry
    end
    it 'increments the cart entry quantity' do
      order = Order.first
      Order.add_product(products(:avocadotoast), orders(:persons_order).id)
      order.cart_entries.count.must_equal 1
    end
  end
end
