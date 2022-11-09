class GroupUsersController < ApplicationController
  include GroupUsersHelper

  def join
    group_user = GroupUser.new
    group_user.user_id = current_user.id
    group_user.group_id = params[:gid]
    logger.info "++DEBUG++ PARAMS: #{params[:gid]}"

    if group_user.save
      flash[:notice] = "Join successfully!"
    else
      flash[:notice] = "Oops, couldn't join at this point. Please try again later."
    end

    redirect_to "/groups/#{params[:gid]}"

  end

  def leave
    GroupUser.where(user_id: current_user.id, group_id: params[:gid]).destroy_all

    redirect_to "/groups/#{params[:gid]}"
  end

  def index
    @users = User.all
    @group = Group.find(params[:gid])
  end

  def create
    uid = params[:uid]
    gid = params[:gid]

    @group_user = User.new(user_params)
    # @user.posts = Post.new(message: "I am #{@user.username}, This is my first post!", groupid: 0)

    if @user.save
      # @user.posts.save
      log_in @user

      logger.info "++DEBUG++ Logged in? #{logged_in?}"
      flash[:notice] = "Account created successfully!"
      redirect_to current_user
    else
      flash[:notice] = "Oops, couldn't create account. Please make sure you are using a valid name and password and try again."
      render :new, status: :unprocessable_entity
    end
  end

end
