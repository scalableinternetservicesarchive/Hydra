class Comment < ApplicationRecord
  belongs_to :post
  has_one :user
end
