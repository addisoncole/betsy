class ApplicationController < ActionController::Base
  before_action :logged_in?
  include CurrentCart
  before_action :find_order

  private

  def logged_in?
    @logged_in_user = User.find_by(id: session[:user_id])
  end

  def find_order
    @order = Order.find_by(id: session[:order_id])
    unless @order
      @order = Order.create
      session[:order_id] = @order.id
    end
  end
end
