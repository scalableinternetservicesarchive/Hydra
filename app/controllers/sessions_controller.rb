class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:session][:username])
    if user && user.authenticate(params[:session][:password_digest])
      # puts " ++DEBUG++ into_login?"
      current_user
      log_in(user)
      flash[:notice] = "Login successfully."
      redirect_to user
    else
      # Create an error message
      # puts " ++DEBUG++ login_fail?"
      # puts "++DEBUG++ notice?"
      redirect_to root_url, notice: 'Invalid username/password combination.'
      # flash[:notice] = "Invalid username/password combination."
    end
  end

  def destroy
    log_out
    redirect_to root_url, notice: 'Logged Out'
  end
end
