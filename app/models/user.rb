class User < ActiveRecord::Base
  has_secure_password

  validates :password, presence: true, confirmation: true, length: { within: 6..40 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
