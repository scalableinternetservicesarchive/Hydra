class PostsController < ApplicationController

  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find_by(Username: @post.Username)
  end

  def new
    @post = Post.new
    @comment = Comment.new
  end

  def create
    @post = Post.new(Message: params[:post][:Message], Likes: 0, Username: current_user.Username)

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path, status: :see_other
  end

  private
  def post_params
    params.require(:post).permit(:Message, :Username)
  end
end
