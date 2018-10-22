class CartEntriesController < ApplicationController
  include CurrentCart
  before_action :find_cart_entry, only: [:show, :edit, :update, :destroy]
  before_action :find_order, only: [:create]

  def index
    @cart_entries = CartEntry.all
  end

  def show
  end

  def new
    @cart_entry = CartEntry.new
  end

  def edit
  end

  def create
    @product = Product.find(params[:product_id])
    @cart_entry = @order.add_product(@product, session[:order_id])

    if @cart_entry.order_id == nil
      @cart_entry.order_id = @order.id
    end
    if @cart_entry.save
    flash[:success] = "Item succesfully added to cart"
    redirect_to request.referrer
    else
      flash[:error] = "ERRORRRRR"
      redirect_to request.referrer
    end

  end

  def destroy
    @order = Order.find(session[:cart_id])
    @cart_entry.destroy
  end

  private

  def find_cart_entry
    @cart_entry = CartEntry.find(params[:id])
  end

  def cart_entry_params
    params.require(:cart_entry).permit(:product_id)
  end

end
