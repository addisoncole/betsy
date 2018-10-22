class OrdersController < ApplicationController

  before_action :find_order, only: [:show, :edit, :update, :destroy]

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

  def create
    @order = Order.new(order_params)
  end

  def destroy
    @order.destroy if @order.id == session[:order.id]
    session[:order_id] = nil
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.fetch(:order, {})
  end

end
