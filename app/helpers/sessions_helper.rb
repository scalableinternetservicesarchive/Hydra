module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    session[:user_name] = user.name
  end

  # def authenticate(user)
  #   if
  # end

  # def current_user
  #   $current_user ||= User.find_by(id: session[:user_id])
  #   puts " ++DEBUG++ #{$current_user}"
  # end

  def logged_in?
    !@current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    session.delete(:user_name)
    @current_user = nil
  end
end
