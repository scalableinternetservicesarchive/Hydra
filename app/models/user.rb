class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :about, presence: true, length: { minimum: 10 }
  validates :email, presence: true
  validates :avatar, presence: true
end
