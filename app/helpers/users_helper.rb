module UsersHelper

  def display_merchant_page_or_user_profile?(user, session_id)
    if user.merchant
       (render partial: "merchant_show").html_safe
     else
      session_id == nil ? ("Members Only").html_safe : (render partial: "user_show").html_safe
    end
  end

  def get_merchants(users)
    users.find_all { |user| user.merchant == true }
  end

  def display_edit_pop_up_button?(user)
    return (link_to "Edit yr pop-up", edit_user_path(user_id: user)).html_safe unless !current_user_page_owner?
  end

  def display_edit_button?(user)
    return (link_to "Edit yr profile", edit_user_path(user_id: user)).html_safe unless !current_user_page_owner?
  end

  def display_sign_up_button?(user)
    if current_user_page_owner?
      if !user.merchant
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

  def non_pending_orders(user)
    return user.orders.find_all { |order| order.status != "pending" }
  end

  def find_my_entries(order)
    my_products = @logged_in_user.products.ids
    my_entries = []
    order.cart_entries.each do |entry|
      if my_products.include?(entry.product_id)
        my_entries << entry
      end
    end

    return my_entries
  end

  def find_entry_cost(entry)
    price = Product.find(entry.product_id).price
    return price * entry.quantity
  end

  def display_ship_button(entry)
    if entry.status == "shipped"
      (button_to "completed").html_safe
    else
      # (button_to "i shipped it", )
    end
  end

  def total_revenue(orders)
    my_products = @logged_in_user.products.ids
    entries = []

    orders.each do |order|
      order.cart_entries.each do |entry|
        if my_products.include?(entry.product_id)
          price = Product.find(entry.product_id).price
          entries << (entry.quantity * price)
        end
      end
    end

    return entries.sum
  end

  def monthly_revenue(month, orders)
    my_products = @logged_in_user.products.ids
    entries = []

    orders.each do |order|
      order.cart_entries.each do |entry|
        if my_products.include?(entry.product_id) && entry.status == "paid" && order.updated_at.mon == month
          price = Product.find(entry.product_id).price
          entries << (entry.quantity * price)
        end
      end
    end

    return entries.sum
  end

  # turn back while you still can . . .
  # this is your last chance ! ! !
  #
  # very well . . .   as you wish . . .
  #
  # the warning was given , this all-hallows eve ;
  # the foolhardy among you chose not to turn back ;
  # bravery turns to recklessness turns to despair as you encounter . . .
  # T H E   C U R S E D   M E T H O D ! ! !
  # you are now marked for life . . . .
  def da_ordah_splittah_numoratorrr(ssstatus, orders)
    # Saint Metz, please forgive us our trespasses . . .

    return orders.map { |order| order.cart_entries.find_all { |entry|
      entry.status == ssstatus && @logged_in_user.products.ids.include?(entry.product_id)
    }.length}.sum
  end
end
