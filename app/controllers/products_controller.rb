require 'pry'
class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
# binding.pry
    if @product.save
      flash[:success] = "Successfully uploaded \"#{@product.name}\""
      redirect_to products_path
    else
      flash.now[:error] = "Invalid product data. Unable to save."
      render :new, status: :bad_request
    end
  end

  def show
    render_404 unless @product
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @product.destroy
    flash[:status] = :success
    flash[:result_text] = "Successfully destroyed #{@product.singularize} #{@product.id}"
    redirect_to root_path
  end


  private
  def product_params
    params.require(:product).permit(:category, :name, :price, :quantity, :image)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end
end
