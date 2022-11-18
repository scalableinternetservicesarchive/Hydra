class DashboardController < ApplicationController
  include AccessControlConcern
  skip_before_action :verify_authenticity_token
  def index
    @users = User.all
    @groups = Group.all
    @posts = Post.where(groupid: 0)
    @post =Post.new
  end
end
