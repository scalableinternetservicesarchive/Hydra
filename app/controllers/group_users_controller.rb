class GroupUsersController < ApplicationController
  include GroupUsersHelper

  def join
    @group_user = GroupUser.new
  end

end
