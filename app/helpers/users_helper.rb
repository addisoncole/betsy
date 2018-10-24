module UsersHelper

  def display_edit_pop_up_button?(user)
    if @user == User.find_by(id: session[:user_id])
      (link_to "Edit yr pop-up", edit_user_path(user_id: user)).html_safe
    end
  end

  def display_edit_button?(user)
    if @user == User.find_by(id: session[:user_id])
      (link_to "Edit yr profile", edit_user_path(user_id: user)).html_safe
    end
  end

  def display_sign_up_button?(user)
    if @user == User.find_by(id: session[:user_id])
      if !@user.merchant
        (link_to "Start yr pop up", edit_user_path(user_id: user)).html_safe
      end
    end
  end

  def display_add_new_product?(user)
    if @user == User.find_by(id: session[:user_id])
      (link_to "Add new swag to pop-up", new_product_path).html_safe
    end
  end

  def display_users_join_date(date)
    ("<span>" + "Member since: " + date.strftime("%b %d") + ", 2k" +  date.strftime("%y") + "</span>").html_safe
  end

  def get_merchant_average_rating(user)
    products = user.products
    rating = 0.0
    count = 0.0
    products.each do |product|
      if product.reviews
        product.reviews.each do |review|
          rating += review.rating
          count += 1
        end
      end
    end
    if count == 0.0
      return "Review my swag! I have no reviews."
    else
      return "%.1f" % (rating/count)
    end
  end

end
