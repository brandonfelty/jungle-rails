class User < ApplicationRecord

  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :email, uniqueness: { case_sensitive: true }
  validates :email, :first_name, :last_name, presence: true
  before_save :downcase_email

  def downcase_email
    self.email.downcase!
 end

  def self.authenticate_with_credentials(email, password)
    clean_email = email.delete(' ').downcase
    user = User.find_by_email(clean_email)
    is_authenticated = user && user.authenticate(password)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
