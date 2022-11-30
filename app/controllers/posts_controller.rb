class PostsController < ApplicationController
  include AccessControlConcern
  before_action :require_login, :except => [ :index ]
  require 'date'

  def index
    # display posts which are public (has group_id:nil), or are part of a group the user belongs to
    group_user = logged_in? ? GroupUser.where(user_id:current_user.id) : []
    arr = [0]
    for g_u in group_user do
      arr.push(g_u.group_id)
    end
    @group_posts = Post.where(groupid:arr).includes(:comments)
    @pub_posts = Post.where(groupid:0).includes(:comments).limit(500).order("date desc")
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(current_user.id)
    @comment = Comment.new
  end

  def new
    # @user = User.find(params[:user_id])
    @post = Post.new
    @comment = Comment.new
  end

  def create
    # begin
    #   user = User.find(post_params[:user_id].to_i)
    # rescue
    #   flash.alert = "User not found."
    #   redirect_to new_post_path and return
    # end
    # @user = User.find(params[:user_id])

    time = Time.new
    # @post = Post.create(message: post_params[:message], user_id: current_user.id, groupid: post_params[:groupid], date: time)
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.message = post_params[:message]
    @post.groupid = params[:groupid] || post_params[:groupid]
    @post.date = time


    if @post.save
      puts " ++DEBUG++ post_save?"
      redirect_to post_path(@post)
    else
      puts " ++DEBUG++ new post fail"
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


  private
  def post_params
    params.require(:post).permit(:message, :user_id, :groupid, :date)
  end


end
