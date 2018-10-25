module UsersHelper

  def display_edit_pop_up_button?(user)
    return (link_to "Edit yr pop-up", edit_user_path(user_id: user)).html_safe unless !current_user_page_owner?
  end

  def display_edit_button?(user)
    return (link_to "Edit yr profile", edit_user_path(user_id: user)).html_safe unless !current_user_page_owner?
  end

  def display_sign_up_button?(user)
    if current_user_page_owner?
      if !@user.merchant
        (link_to "Start yr pop up", edit_user_path(user_id: user)).html_safe
      end
    end
  end

  def display_add_new_product?(user)
    return (link_to "Add new swag to pop-up", new_product_path).html_safe unless !current_user_page_owner?
  end

  def display_users_join_date(date)
    ("<span>" + "Member since: " + date.strftime("%b %d") + ", 2k" +  date.strftime("%y") + "</span>").html_safe
  end

  def get_merchant_average_rating(user)
    rating = 0.0
    count = 0.0
    user.products.each do |product|
      if product.reviews
        product.reviews.each do |review|
          rating += review.rating
          count += 1
        end
      end
    end
    count == 0.0 ? "Review my swag!" : ("%.1f" % (rating/count))
  end

  private

  def current_user_page_owner?
    @user == User.find_by(id: session[:user_id])
  end

end
