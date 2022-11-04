class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :about, presence: true, length: { minimum: 10 }
  validates :email, presence: true
  validates :pic_url, presence: true
end
