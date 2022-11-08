class DashboardController < ApplicationController
  include AccessControlConcern

  def index
    @users = User.all
    @groups = Group.all
    @posts = Post.where(groupid: 0)
    @post =Post.new
  end
end
