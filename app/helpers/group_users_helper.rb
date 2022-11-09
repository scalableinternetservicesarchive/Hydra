module GroupUsersHelper
  def basic_params

  end

  def group_contains_user?(group, user)
    GroupUser.where(user_id: user.id, group_id: group.id).exists?
  end

end
