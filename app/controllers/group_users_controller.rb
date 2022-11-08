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

    redirect_to current_user

  end

  def leave

  end

end
