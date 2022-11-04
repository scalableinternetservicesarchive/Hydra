class ApplicationController < ActionController::Base

  include SessionsHelper

  helper_method :current_user

  def current_user
    # Look up the current user based on user_id in the session cookie:
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found! Are you sure you entered a valid path?')
  end

end
