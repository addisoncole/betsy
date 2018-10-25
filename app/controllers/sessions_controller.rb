class SessionsController < ApplicationController

  def login
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if user
      flash[:success] = "Get in, loser. We're going shopping. \u{1F485}"
      session[:order_id] = nil
    else
      user = User.build_user_hash(auth_hash)

      if user.save
        flash[:success] = "Logged in as new loser #{user.name}. We're going shopping. \u{1F485}"
        session[:order_id] = nil
      else
        flash[:error] = "Could not create new loser account: #{user.errors.messages}"
        redirect_to root_path
        return
      end

    end
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    session[:order_id] = nil
    flash[:success] = "You have been logged out. Been there. Shopped that. \u{1F485}"

    redirect_to root_path
  end


end
