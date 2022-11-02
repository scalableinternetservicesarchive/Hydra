class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(Username: current_user.Username, body: params[:comment][:Message])
    redirect_to @post
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to @post
  end

  # private
  # def comments_params
  #   params.require(:comment).permit(:commenter, :body)
  # end
end
