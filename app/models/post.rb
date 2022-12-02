class Post < ApplicationRecord
  belongs_to :user, touch: true
  has_many :comments
  paginates_per 10
end
