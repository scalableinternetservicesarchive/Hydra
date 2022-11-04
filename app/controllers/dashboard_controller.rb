class DashboardController < ApplicationController
  def index
    @users = User.all
    @groups = Group.all
    @posts = Post.all
    @post =Post.new
  end
end
