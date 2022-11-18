class GroupUsersController < ApplicationController
  include GroupUsersHelper
  skip_before_action :verify_authenticity_token

  def join
    group_user = GroupUser.new
    group_user.user_id = current_user.id
    group_user.group_id = params[:gid]
    group_user.permission = false
    logger.info "++DEBUG++ PARAMS: #{params[:gid]}"

    if group_user.save
      flash[:notice] = "Join successfully!"
    else
      flash[:notice] = "Oops, couldn't join at this point. Please try again later."
    end

    redirect_to "/groups/#{params[:gid]}", status: :ok

  end

  def leave
    GroupUser.where(user_id: current_user.id, group_id: params[:gid]).destroy_all

    redirect_to "/groups/#{params[:gid]}", status: :ok
  end

  def edit
    @group_user = GroupUser.where(group_id:params[:group])
    @group = Group.find(params[:group])
  end

  def transferownership
    fromuid = params[:fromuid]
    touid = params[:touid]
    @group = Group.find(params[:gid])
    @group_user1 = GroupUser.where(user_id: fromuid, group_id: params[:gid]) rescue not_found
    @group_user2 = GroupUser.where(user_id: touid, group_id: params[:gid]) rescue not_found

    if @group_user1.update(user_id: fromuid, group_id: params[:gid],permission:false) and @group_user2.update(user_id: touid, group_id: params[:gid],permission:true)
      redirect_to @group, status: :ok
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
    @group = Group.find(params[:gid])
  end

  def create
    uid = params[:uid]
    gid = params[:gid]

    @group_user = GroupUser.new(user_id: uid, group_id: gid,permission:false)

    if @group_user.save
      flash[:notice] = "Successfully add user to group!"
    else
      flash[:notice] = "Oops, cannot finish the operation. Please try again later."
    end
    redirect_to groupusers_path(:gid => gid), status: :ok
  end

  def destroy
    uid = params[:uid]
    gid = params[:gid]

    GroupUser.where(user_id: uid, group_id: gid).destroy_all

    redirect_to groupusers_path(:gid => gid), status: :see_other
  end

end
