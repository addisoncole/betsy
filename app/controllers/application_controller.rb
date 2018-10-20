class ApplicationController < ActionController::Base
  before_action :logged_in?

private

def logged_in?
  @logged_in_user = User.find_by(id: session[:user_id])
end

end
