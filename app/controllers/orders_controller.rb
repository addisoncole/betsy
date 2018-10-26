class OrdersController < ApplicationController

  before_action :find_order, only: [:show, :edit, :update, :destroy, :checkout]

  def show
  end

  def update
    if @order.update(order_params)
      @order.decrement_products
      @order.mark_paid
      session[:order_id] = nil
      redirect_to order_checkout_path(@order)
    else
    end
  end

  def create
    @order = Order.new(order_params)
    # if @order.save
    #   redirect_back(fallback_location: root_path)
    # else
    #   redirect_to root_path
    # end

  end

  def destroy
    @order.destroy if @order.id == session[:order.id]
    session[:order_id] = nil
  end

  def checkout
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    return params.require(:order).permit(:name, :billing_address, :email, :shipping_address, :billing_zip_code, :card_number, :card_expiration, :CVV)
  end

end
