require "test_helper"
require 'pry'

describe Order do
  describe "validations" do
    it "is valid when status is pending and no feilds are present" do
      @order = Order.new(status: "pending")
      binding.pry
      @order.valid?.must_equal true
    end
    it "is valid when status is paid and all feilds are present" do
      @order = Order.new(status: "paid", card_number: "2222222222222222", card_expiration: "10/12", CVV: "123", billing_zip_code: "12345", shipping_address: "fff", billing_address: "fff", email: "fff", name: "fff")
      @order.valid?.must_equal true
    end
  end
end

#   create_table "orders", force: :cascade do |t|
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.bigint "card_number"
#     t.string "card_expiration"
#     t.integer "CVV"
#     t.integer "billing_zip_code"
#     t.string "shipping_address"
#     t.string "email"
#     t.string "billing_address"
#     t.string "status", default: "pending"
#     t.string "name"
#   end
#
#
# describe CartEntry do
#   describe "validations" do
#     it "is valid when all fields are present" do
#       @user = User.first
#       @order = Order.new
#       @order.save!
#       @product = Product.new(name: 'Artisanal Coffee', category: "Lifestyle", quantity: 4, price: 9.99, image: 'https://placekitten.com/200/200', user: @user)
#       @product.save!
#       cart_entry = CartEntry.new(order: @order, order_id: @order.id, product: @product, product_id: @product.id)
#       cart_entry.valid?.must_equal true
#     end
#
#     it "requires an order" do
#       cart_entry = CartEntry.new
#       cart_entry.valid?.must_equal false
#       cart_entry.errors.messages.must_include :order
#     end
#
#     it "requires a product" do
#       order_id = 1
#       cart_entry = CartEntry.new(order_id: order_id)
#       cart_entry.valid?.must_equal false
#       cart_entry.errors.messages.must_include :product
#     end
#
#     it "requires a quantity" do
#       order_id = 1
#       product_id = 1
#       cart_entry = CartEntry.new(order_id: order_id, product_id: product_id)
#       cart_entry.quantity = nil
#       cart_entry.valid?.must_equal false
#       cart_entry.errors.messages.must_include :quantity
#     end
#
#     it 'the quantity must be of type integer' do
#       @order = Order.new
#       @order.save!
#       product_id = 1
#       cart_entry = CartEntry.new(order: @order, order_id: @order.id, product_id: product_id, quantity: 'string')
#       cart_entry.valid?.must_equal false
#       cart_entry.errors.messages.must_include :quantity
#     end
#
#     it 'quantity must be greater than zero' do
#       @order = Order.new
#       @order.save!
#       product_id = 1
#       cart_entry = CartEntry.new(order: @order, order_id: @order.id, product_id: product_id, quantity: 0)
#       cart_entry.valid?.must_equal false
#       cart_entry.errors.messages.must_include :quantity
#     end
#
#     it 'quantity cannot be a negative number' do
#       @order = Order.new
#       @order.save!
#       product_id = 1
#       cart_entry = CartEntry.new(order: @order, order_id: @order.id, product_id: product_id, quantity: -1)
#       cart_entry.valid?.must_equal false
#       cart_entry.errors.messages.must_include :quantity
#     end
#   end
#
#   describe 'relations' do
#     it 'has an order' do
#       cart_entry = cart_entries(:entry)
#       cart_entry.order.must_equal orders(:persons_order)
#     end
#
#     it "can set the order" do
#       cart_entry = CartEntry.new
#       cart_entry.order = orders(:persons_order)
#       cart_entry.order_id.must_equal orders(:persons_order).id
#     end
#
#     it 'has a product' do
#       cart_entry = cart_entries(:entry)
#       cart_entry.product.must_equal products(:avocadotoast)
#     end
#
#     it "can set the product" do
#       cart_entry = CartEntry.new
#       cart_entry.product = products(:avocadotoast)
#       cart_entry.product_id.must_equal products(:avocadotoast).id
#     end
#
#   end
# end
#
#
# has_many :cart_entries, dependent: :destroy
# validates :card_number, :presence, if: Proc.new { |a| a.status == "paid" }
# validates :card_expiration, :presence, if: Proc.new { |a| a.status == "paid" }
# validates :CVV, :presence, if: Proc.new { |a| a.status == "paid" }
# validates :billing_address, :presence, if: Proc.new { |a| a.status == "paid" }
# validates :billing_zip_code, :presence, if: Proc.new { |a| a.status == "paid" }
# validates :email, :presence, if: Proc.new { |a| a.status == "paid" }
# validates :shipping_address, :presence, if: Proc.new { |a| a.status == "paid" }
