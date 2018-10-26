require "test_helper"

describe OrdersController do
  describe "show" do
    it "will get show for valid ids" do
      id = orders(:persons_order).id
      get order_path(id)
      must_respond_with :success
    end
  end
  describe "update" do
    let (:order_hash) {
      {
        order: {
          status: "Pending"
        }
      }
    }
    it "will update a model with a valid post request" do
      id = orders(:persons_order).id
      expect {
        patch order_path(id), params: order_hash
      }.wont_change 'Order.count'
      order = Order.find_by(id: id)
      expect(order.status).must_equal order_hash[:order][:status]
    end
  end
end
    # it "will respond with not_found for invalid ids" do
    #   id = -1
    #
    #   expect {
    #     patch order_path(id), params: order_hash
    #   }.wont_change 'Order.count'
    #
    #   must_respond_with :not_found
    # end
  # describe "create" do
  #   it "can create an order" do
  #     order_hash = {
  #       order: {
  #         card_number: 1111111111111111,
  #         card_expiration: 10/2018,
  #         CVV: 123,
  #         billing_zip_code: 98223,
  #         shipping_address: "123 idk lane",
  #         email: "Email@email.email",
  #         billing_address: "1234 idk lane",
  #         status: "Pending",
  #         name: "jjj"
  #       }
  #     }
  #
  #     test_order = Order.new(order_hash[:order])
  #     test_order.must_be :valid?, "Order data was invalid"
  #
  #     # expect {
  #     #   post orders_path, params: order_hash
  #     # }.must_change('Order.count', +1)
  #
  #     # must_redirect_to order_path(Order.last)
  #     expect(Order.last.card_number).must_equal order_hash[:order][:card_number]
  #     expect(Order.last.card_expiration).must_equal order_hash[:order][:card_expiration]
  #     expect(Order.last.CVV).must_equal order_hash[:order][:CVV]
  #     expect(Order.last.billing_zip_code).must_equal order_hash[:order][:billing_zip_code]
  #     expect(Order.last.shipping_address).must_equal order_hash[:order][:shipping_address]
  #     expect(Order.last.email).must_equal order_hash[:order][:email]
  #     expect(Order.last.billing_address).must_equal order_hash[:order][:billing_address]
  #     expect(Order.last.status).must_equal order_hash[:order][:status]
  #     expect(Order.last.name).must_equal order_hash[:order][:name]
  #   end
  # end

# def create
#   @order = Order.new(order_params)
# end
#
# def destroy
#   @order.destroy if @order.id == session[:order.id]
#   session[:order_id] = nil
# end
#
# def checkout
# end
#
# private
#
# def find_order
#   @order = Order.find(params[:id])
# end
#
# def order_params
#   return params.require(:order).permit(:name, :billing_address, :email, :shipping_address, :billing_zip_code, :card_number, :card_expiration, :CVV)
# end
#
# end
