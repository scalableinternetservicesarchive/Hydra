class User < ApplicationRecord
  has_many :posts
  before_save { self.email = email.downcase }
  paginates_per 5

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }
  validates :about, presence: true, length: { minimum: 10 }
  VALID_EMAIL_REGEX = /\A\S+@.+\.\S+\z/
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :pic_url, presence: true
  VALID_STATUSES = %w[online offline invisible busy]
  validates :status, inclusion: { in: VALID_STATUSES }

  has_secure_password
  validates :password, presence: true
end
