class User < ApplicationRecord
  has_secure_password  # simple auth support for model using password_digest column

  attr_accessor :email, :password, :password_confirmation

  validates_uniqueness_of :email

  #NOTE
  # We don’t need to validate the presence of the password and password_confirmation fields, 
  #however, as this will be handled by has_secure_password.
end
