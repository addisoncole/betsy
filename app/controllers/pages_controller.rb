class PagesController < ApplicationController
  def show
    @popups = User.where(merchant: true)
    @swags = Product.order(created_at: :desc)
    render template: "pages/#{params[:page]}"
  end
end
