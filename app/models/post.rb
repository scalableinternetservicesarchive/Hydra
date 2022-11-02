class Post < ApplicationRecord
  validates :Message, presence: true
  # validates :user_id, presence: true, inclusion: { in: User.all,
  #                                               message: "User id %{value} is not in user's list"}
  validates :Username, presence: true
end
