class UsersController < ApplicationController

  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user?, only: [:edit, :destroy]

  def index
    if User.find_by(id: session[:user_id])
      @users = User.all
    else
      flash[:error] = "Must be logged in to do that."
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def show
    if User.find_by(id: session[:user_id])
      @user = User.find_by(id: params[:id])
    else
      flash[:error] = "Members Only"
      redirect_to root_path
    end
  end

  def edit
    unless current_user?
      redirect_to root_path, :alert => "Members Only"
    end
  end

  def update
  end

  def destroy
    if current_user?
      @user.destroy
      flash[:status] = :success
      flash[:result_text] = "Successfully destroyed #{@user.singularize} #{@user.id}"
      redirect_to root_path
    else
      flash[:error] = "Must be logged in as user to do that."
      redirect_to root_path
    end
  else
    flash[:error] = "Members Only"
    redirect_to root_path
  end

  def userdash
    @products = @user.products
    @orders = @user.orders
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :email, :merchant)
  end
  def find_user
    @user = User.find_by(id: params[:id])
  end
  def current_user?
    @user == User.find_by(id: session[:user_id])
  end
end
