class OrdersController < ApplicationController

  before_action :find_order, only: [:show, :edit, :update, :destroy, :checkout]

  def index
    @orders = Order.all
  end

  def show

  end

  def new
    @order = Order.new
  end

  def edit
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
