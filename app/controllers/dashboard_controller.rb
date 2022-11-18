class DashboardController < ApplicationController
  include AccessControlConcern
  @@post_limit = 5
  @@rec_user_limit = 5
  @@rec_group_limit =3
  
  def index
    @users = User.all
    @groups = Group.all
    @posts = Post.where(groupid: 0)
    @limited_posts = Post.where(groupid: 0).limit(@@post_limit)
    @rec_users = @users.limit(@@rec_user_limit)
    @rec_groups = @groups.limit(@@rec_group_limit)
    @post =Post.new
  end

  def show_more_posts
    @@post_limit += 5
    redirect_to "/dashboard"
  end

  def show_more_rec_users
    @@rec_user_limit += 5
    redirect_to "/dashboard"
  end

  def show_more_rec_groups
    @@rec_group_limit += 3
    redirect_to "/dashboard"
  end
end