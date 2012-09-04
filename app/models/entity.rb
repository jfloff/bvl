#encoding: utf-8

# == Schema Information
#
# Table name: entities
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class Entity < ActiveRecord::Base
  
  attr_accessible :username, :name, :email, :password, :password_confirmation

  has_secure_password

  before_save :downcase_username_and_email
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A([a-z0-9_])+\z/i

  validate :check_sign_in

  validates :name, presence: true
  validates :username, presence: true, length: { maximum: 15 }, format: { with: VALID_USERNAME_REGEX }, 
            uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
             uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # Custom URLs
  extend FriendlyId
  FriendlyId.defaults do |config|
    config.use :reserved
    config.reserved_words = %w(new edit signup)
  end
  friendly_id :username


  def downcase_username_and_email
		self.email.downcase!
		self.username.downcase!
	end

  def check_sign_in
    volunteer = Volunteer.find_by_username(self.username)
    unless volunteer.nil?
      errors.add(:username, " já existe.")
    end
    volunteer = Volunteer.find_by_email(self.email)
    unless volunteer.nil?
      errors.add(:email, " já existe.")
    end
  end
end
