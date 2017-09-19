class User < ActiveRecord::Base
  has_many :courses
  has_secure_password

  validates :username, presence: true
end
