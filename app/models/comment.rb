class Comment < ApplicationRecord
  belongs_to :post, touch: true
  has_one :user
end
