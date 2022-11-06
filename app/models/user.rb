class User < ApplicationRecord
  has_many :posts
  before_save { self.email = email.downcase }

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }
  validates :about, presence: true, length: { minimum: 10 }
  VALID_EMAIL_REGEX = /\A\S+@.+\.\S+\z/
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :pic_url, presence: true

  has_secure_password
  validates :password, presence: true
end
