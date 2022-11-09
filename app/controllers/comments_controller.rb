class CommentsController < ApplicationController
  
  require 'date'

  def create
    time = Time.new
    @post = Post.find(params[:post_id])
    #user = current_user.id
    #@user = User.find(current_user.id)
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = params[:post_id]
    @comment.date = time
    @comment.comment = [:comment]
    redirect_to post_path(@post)
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :comment, :date, :post_id)
  end
end
