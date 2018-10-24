require 'pry'
class CartEntriesController < ApplicationController
  include CurrentCart
  before_action :find_cart_entry, only: [:edit, :update, :destroy]
  before_action :find_order, only: [:create]

  def edit
  end

  def update
    if @cart_entry.update(params[:cart_entry][:quantity].to_i)
      redirect_to order_path(@cart_entry.order_id)
    else
      render :edit, status: :bad_request
    end
  end

  def create
    @product = Product.find(params[:product_id])
    head :not_found unless @product

    if params[:cart_entry] != nil
      @cart_entry = @order.add_product(@product, session[:order_id], params[:cart_entry][:quantity].to_i)
    end

    if !@cart_entry
      flash[:error] = "Product unavailable, needs more swag"
      redirect_to product_path(@product.id)
      return
    end

    if @cart_entry.save
      flash[:success] = "Item succesfully added to cart"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "ERRORRRRR"
      redirect_to product_path(@product.id)
    end
  end

  def destroy
    @order = Order.find(session[:cart_id])
    if @cart_entry.destroy
      flash[:status] = :success
      flash[:result_text] = "Successfully destroyed #{@cart_entry.product_id}"
      redirect_to carts_path
    end
  end

  private

  def find_cart_entry
    @cart_entry = CartEntry.find(params[:id])

  end
endr
