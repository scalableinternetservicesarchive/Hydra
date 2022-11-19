class UsersController < ApplicationController
  before_action :require_login, :except => [:new, :create, :index]

  def index
    @users = User.order(:username).page params[:page]
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
    @groupusers = GroupUser.where(user_id: @user.id)
  end

  def new
    @user = User.new
    @post = Post.new
  end

  def create
    @user = User.new(user_params)
    @user.status = 'offline'
    # @user.posts = Post.new(message: "I am #{@user.username}, This is my first post!", groupid: 0)

    if @user.save
      # @user.posts.save
      log_in @user

      logger.info "++DEBUG++ Logged in? #{logged_in?}"
      flash[:notice] = "Account created successfully!"
      redirect_to current_user, status: :ok
    else
      flash[:notice] = "Oops, couldn't create account. Please make sure you are using a valid name and password and try again."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user, status: :ok
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    uid = params[:uid]
    logger.info "++DEBUG++ profile deletion requested by uid #{uid}"
    User.where(id: uid).destroy_all
    log_out
    flash[:alert]= "Profile deleted"
    redirect_to root_url, status: :see_other
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :about, :email, :pic_url)
  end

  private
  def require_login
    unless logged_in?
      flash[:alert]= "Please log in to view the requested page"
      redirect_to users_path, status: :forbidden
    end
  end
end
