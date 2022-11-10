module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
    session[:user_name] = user.username
    user_params = User.find(session[:user_id]).as_json
    user_params['status'] = 'online'
    User.update(session[:user_id], user_params)
    logger.info "++DEBUG++ inspect: #{User.find(session[:user_id]).inspect}"
    session[:status] = current_user.status
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    User.update(current_user.id, :status => 'offline')
    logger.info "++DEBUG++ inspect: #{current_user.inspect}"
    session.delete(:user_id)
    session.delete(:user_name)
    session.delete(:status)
    @current_user = nil
  end

end
