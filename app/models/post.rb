class Post < ApplicationRecord
  belongs_to :user, touch: true
  has_many :comments
end
