module UsersHelper

  def display_edit_button?(user)
    if @user == User.find_by(id: session[:user_id])
       (link_to "Edit yr pop-up", edit_user_path(user_id: user)).html_safe
    end
  end

 def display_add_new_product?(user)
   if @user.merchant
     (link_to "Add new swag to pop-up", new_product_path).html_safe
   end
 end

  def display_store_name_or_users_name(user)
    if @user.store_name
      return @user.store_name
    else
      return @user.name.downcase
    end
  end

  def display_users_join_date(date)
    ("<span>" + "Member since: " + date.strftime("%b %d") + ", 2k" +  date.strftime("%y") + "</span>").html_safe
  end

end
