module GroupUsersHelper
  def basic_params

  end

  def group_contains_user?(group, user)
    # the user needs to be in the group AND the user needs to have edit permission
    GroupUser.where(user_id: user.id, group_id: group.id).exists?
  end

  def user_can_edit_group?(group, user)
    # the user needs to be in the group AND the user needs to have edit permission
    GroupUser.where(user_id: user.id, group_id: group.id,permission:true).exists?
  end

end
