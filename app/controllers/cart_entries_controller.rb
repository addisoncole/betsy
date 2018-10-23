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
    head :not_found unless @product

    @cart_entry = @order.add_product(@product, session[:order_id])

    if @cart_entry.order_id == nil
      @cart_entry.order_id = @order.id
    end
    if @cart_entry.save
      flash[:success] = "Item succesfully added to cart"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "ERRORRRRR"
      render :new, status: :bad_request
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

  def cart_entry_params
    params.require(:cart_entry).permit(:product_id)
  end
end
