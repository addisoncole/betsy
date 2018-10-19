class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def show
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end

  def edit
  end

  def update
  end

  def destroy
    @user.destroy
    flash[:status] = :success
    flash[:result_text] = "Successfully destroyed #{@user.singularize} #{@user.id}"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :email, :merchant)
  end
  def find_user
    @user = User.find_by(id: params[:id])
  end

end
