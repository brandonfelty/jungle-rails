class User < ApplicationRecord

  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :email, uniqueness: { case_sensitive: true }
  validates :email, :first_name, :last_name, presence: true
end
