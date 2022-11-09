module GroupUsersHelper
  def basic_params

  end

  def group_contains_user?(group, user)
    # the user needs to be in the group AND the user needs to have edit permission
    GroupUser.where(user_id: user.id, group_id: group.id,permission:True).exists?
  end

end
