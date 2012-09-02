# == Schema Information
#
# Table name: volunteers
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Volunteer < ActiveRecord::Base
  attr_accessible :username, :name, :email, :password, :password_confirmation

  has_secure_password

  before_save :downcase_username_and_email
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A([a-z])+\z/i

  validates :name, presence: true
  validates :username, presence: true, length: { maximum: 15 }, format: { with: VALID_USERNAME_REGEX }, 
  					uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  					 uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


  def downcase_username_and_email
		self.email.downcase!
		self.username.downcase!
	end
end
