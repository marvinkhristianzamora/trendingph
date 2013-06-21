class User < ActiveRecord::Base
  has_many :posts

  before_save :create_remember_token
  before_save { self.email.downcase! }

  has_secure_password

  validates :username, presence: true, uniqueness: { case_sensitive: false },
    length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false },
    format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
