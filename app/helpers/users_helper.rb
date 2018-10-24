module UsersHelper

  def display_edit_button?(user)
    if @user == User.find_by(id: session[:user_id])
       (link_to "Edit", edit_user_path(user_id: user)).html_safe
    end
  end

  def display_store_name_or_users_name(user)
    if @user.store_name
      return @user.store_name
    else
      return @user.name.downcase
    end
  end

end
