# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  remember_digest :string
#  admin           :boolean          default(FALSE)
#

class User < ApplicationRecord
  attr_accessor :remember_token

  # Name
  validates :name, presence: true,
                   length: { maximum: 50 }

  # Email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-\.]*[a-z\-\d]\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  before_save { self.email = email.downcase }

  # Password
  has_secure_password
  validates :password, presence: true,
                       length: { minimum: 8 },
                       allow_nil: true

  # Remembers a user in the database for use in persistent sessions.
  def remember
    # Generate a new token, and stored the hashed version in the database.
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    # Remove hashed token from database.
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the stored digest.
  def authenticated?(token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
end
