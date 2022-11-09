module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    session[:user_name] = user.username
    current_user.update(status: 'online')
    session[:status] = current_user.status
  end

  # def authenticate(user)
  #   if
  # end

  # def current_user
  #   $current_user ||= User.find_by(id: session[:user_id])
  #   puts " ++DEBUG++ #{$current_user}"
  # end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    current_user.update(status: 'offline')
    session.delete(:user_id)
    session.delete(:user_name)
    session.delete(:status)
    @current_user = nil
  end
end
