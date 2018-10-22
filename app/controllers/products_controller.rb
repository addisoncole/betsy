class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category]
      @title = "#{params[:category].downcase}"
      @products = Product.where(:category => params[:category])
    else
      @title = "the spread"
      @products = Product.all
    end
  end

  def new
    @product = Product.new(product_params)
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = session[:user_id]

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
    if @product.destroy
      flash[:status] = :success
      flash[:result_text] = "Successfully destroyed #{@product.name}"
      redirect_to products_path
    end
  end

  def review
    @review = Review.new(rating: params[:rating], comment: params[:comment])
    @review.product_id = params[:id]
    @review.user_id = session[:user_id]

    @user = User.find_by(id: @review.user_id)

    if @review.save
      flash[:success] = "Successfully submitted comment!"
      redirect_to request.referrer
    else
      flash[:error] = "A problem occurred: could not save rating and/or review."
      redirect_to product_path(@review.product_id)
    end
  end

  private
  def product_params
    params.require(:product).permit(:category, :name, :price, :quantity, :image, :user_id)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
  end
end
