class SessionsController < ApplicationController

  def login
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if user
      # User was found in the database
      flash[:success] = "Get in, loser. We're going shopping, #{user.name}."
      session[:order_id] = nil
    else
      # User doesn't match anything in the DB
      # Attempt to create a new user
      user = User.build_user_hash(auth_hash)

      if user.save
        flash[:success] = "Logged in as new loser #{user.name}. We're going shopping."
        session[:order_id] = nil
      else
        # Couldn't save the user for some reason. If we
        # hit this it probably means there's a bug with the
        # way we've configured GitHub. Our strategy will
        # be to display error messages to make future
        # debugging easier.
        flash[:error] = "Could not create new loser account: #{user.errors.messages}"
        redirect_to root_path
        return
      end
    end

    # If we get here, we have a valid user instance
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    session[:order_id] = nil
    flash[:success] = "You have been logged out. Been there. Shopped that."

    redirect_to root_path
  end


end
