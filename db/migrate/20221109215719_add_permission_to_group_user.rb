class AddPermissionToGroupUser < ActiveRecord::Migration[7.0]
  def change
    add_column :group_users, :permission, :boolean
  end
end
