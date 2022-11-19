class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  paginates_per 10
end
