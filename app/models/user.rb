class User < ApplicationRecord
  has_secure_password

  validates :Username, presence: true, uniqueness: { case_sensitive: false }
end
