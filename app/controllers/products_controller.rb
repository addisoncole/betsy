class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :product_owner?, only: [:edit, :destroy]
  before_action :is_reviewer_logged_in, only: [:review]


  def index

    if params[:category]
      @title = "#{params[:category].downcase}"
      @products = Product.where(:category => params[:category])
      @products = @products.shuffle
    else
      @title = "the spread"
      @products = Product.all.shuffle
    end
  end

  def new
    @product = Product.new()
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = session[:user_id]

    if @product.save
      flash[:success] = "Successfully uploaded \"#{@product.name}\", you go Glen Coco!"
      redirect_to product_path(@product.id)
    else
      puts "Failed to save product: #{@product.errors.messages}"
      flash.now[:error] = "Invalid product data. Unable to save."
      render :new, status: :bad_request
    end
  end

  def show
    @cart_entry = CartEntry.new
  end

  def edit
    unless product_owner?
      redirect_to products_path, :alert => "Members Only"
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = "Successfully updated yr swag! You go Glen Coco! \u{1F389}"
      redirect_to product_path(@product.id)
    else
      flash[:error] = "Errawr. \u{1F996} Missing some deets, bb."
      render :edit, status: :bad_request
    end
  end

  def destroy
    if product_owner?

      if @product.destroy

        flash[:status] = :success
        flash[:success] = "Successfully destroyed #{@product.name} \u{1F4A5}	"
        redirect_to products_path
      end
    else
      redirect_to products_path, :alert => "Members Only"
    end
  end

  def review
    if @reviewer
      @review = Review.new(rating: params[:rating], comment: params[:comment])
      @review.product_id = params[:id]
      @review.user_id = session[:user_id]

      @product = Product.find_by(id: params[:id])

      @user = User.find_by(id: @review.user_id)

      if @user == @product.user
        flash[:error] = "Errawr. \u{1F996} Cannot review own product, loser."
        redirect_to product_path(@review.product_id)

      else @review.save
        flash[:success] = "Successfully gave your thoughts && prayers! You go Glen Coco! \u{1F389}"
        redirect_to product_path(@review.product_id)
      end
    else
      flash[:error] = "Members Only"
      # @review is nil at this point... you have access to the right id off of params[:id] though
      redirect_to product_path(id: params[:id])
    end
  end

  private
  def product_params
    return params.require(:product).permit(:category, :name, :price, :quantity, :image, :user_id)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
    head :not_found unless @product
  end

  def product_owner?
    @user = User.find_by(id: session[:user_id])
    @user == @product.user
  end

  def is_reviewer_logged_in
    @reviewer = User.find_by(id: session[:user_id])
  end
end
