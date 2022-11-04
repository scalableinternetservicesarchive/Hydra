class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # @posts = Post.where(name: @user.name)
  end

  def new
    @user = User.new
    @post = Post.new
  end

  def create
    @user = User.new(user_params)
    # @user.posts = Post.new(message: "This is my first post!")
    session[:user_id] = @user.id

    if @user.save
      # @user.posts.save
      current_user
      log_in @user
      flash[:notice] = "Account created successfully!"
      redirect_to @user
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
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path, status: :see_other
  end

  private
  def user_params
    params.require(:user).permit(:username, :password_digest, :about, :email, :pic_url)
  end
end
