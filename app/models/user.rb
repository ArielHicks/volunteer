class User < ActiveRecord::Base
  # validates :name, :presence true
  has_secure_password
  has_many :posts
end
