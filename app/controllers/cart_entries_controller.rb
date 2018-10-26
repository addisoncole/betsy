class CartEntriesController < ApplicationController
  include CurrentCart
  before_action :find_cart_entry, only: [:edit, :update, :destroy]
  before_action :find_order, only: [:create]

  def edit
  end

  def update
    if @cart_entry.update(quantity: params[:cart_entry][:quantity].to_i)
      redirect_to order_path(@cart_entry.order_id)
    else
      flash[:error] = "Unable to update quantity. Please try again."
      redirect_to order_path(@cart_entry.order_id)
    end

    # TODO: what if the cart ID on the cart item doesn't match what's in the session?
  end

  def create
    @product = Product.find(params[:product_id])
    head :not_found unless @product

    if params[:cart_entry] != nil
      @cart_entry = Order.add_product(@product, session[:order_id], params[:cart_entry][:quantity].to_i)
    end

    if !@cart_entry
      flash[:error] = "Product unavailable, needs more swag"
      redirect_to product_path(@product.id)
      return
    end

    if @cart_entry.save
      flash[:success] = "Item added to bag, you go, Glen Coco!"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Errawr. \u{1F996} Looks like something was missing."
      redirect_to  product_path(@product.id)
    end
  end

  def destroy
    # @order = Order.find(session[:order_id])
    if @cart_entry.destroy
      flash[:success] = "Successfully destroyed #{@cart_entry.product.name}"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Unable to delete  #{@cart_entry.product.name}"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def find_cart_entry
    @cart_entry = CartEntry.find(params[:id])

  end
end
