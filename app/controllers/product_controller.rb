class ProductController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
  end

  def show
    @product = Product.find_by(id: params[:id])
    render_404 unless @product
  end

  def edit
  end

  def update
  end

  def destroy
    @product.destroy
    flash[:status] = :success
    flash[:result_text] = "Successfully destroyed #{@product.singularize} #{@product.id}"
    redirect_to root_path
  end


  private
  def product_params
    params.require(:product).permit(:category, :name, :price, :quantity)
  end
end
