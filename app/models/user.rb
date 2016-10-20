require 'bcrypt'

class User < ActiveRecord::Base
  has_many :restaurants, foreign_key: :owner_id
  has_many :reviews, foreign_key: :author_id
  has_many :reviewed_restaurants, through: :reviews, source: :restaurant

  validates :email, :username, :password_hash, presence: true
  validates :email, :username, uniqueness: true
  validate :validate_password

  def validate_password
    if @raw_password.nil?
      errors.add(:password_hash, "is required")
    elsif @raw_password.length < 8
      errors.add(:password_hash, "must be 8 characters or more")
    elsif not @raw_password =~ /([!@#$%^&*?\d]+.+|.+[!@#$%^&*?\d]+.+|.+[!@#$%^&*?\d])/
      errors.add(:password_hash, 'must contain a special character or number')
    end
  end

  def password
    @password ||= BCrypt::Password.new(self.password_hash)
  end

  def password=(plain_text_password)
    @raw_password = plain_text_password
    @password = BCrypt::Password.create(plain_text_password)
    self.password_hash =@password
  end

  def authenticate(plain_text_password)
    self.password == plain_text_password
  end
end
