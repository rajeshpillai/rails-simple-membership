class User < ApplicationRecord
  has_secure_password  # simple auth support for model using password_digest column
end
