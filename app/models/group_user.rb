class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user
  paginates_per 10
end
