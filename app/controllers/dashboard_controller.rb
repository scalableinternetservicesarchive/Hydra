class DashboardController < ApplicationController
  include AccessControlConcern

  def index
    @users = User.all
    @groups = Group.all
    @posts = Post.all
    @post =Post.new
  end
end
