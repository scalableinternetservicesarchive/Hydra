class ApplicationController < ActionController::Base

  include SessionsHelper

  helper_method :current_user, :in_group?, :change_status

  def current_user
    # Look up the current user based on user_id in the session cookie:
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def change_status(new_status)
    current_user.update(status: new_status)
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found! Are you sure you entered a valid path?')
  end

  # Group stuff:
  def in_group?(group)
    GroupUser.where(user_id: current_user.id, group_id: group.id).exists?
  end

end
