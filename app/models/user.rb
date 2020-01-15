class User < ApplicationRecord
  has_secure_password  # simple auth support for model using password_digest column
  validates_uniqueness_of :email
  validates :password, length: {minimum: 8}, allow_nil: true
  #attr_accessor :email, :password, :password_confirmation (throws error)

  # To create the token we use ActiveSupport’s 
  # SecureRandom class to generate a random string. 
  # We check that no other user exists with that token and 
  # repeatedly generate another random token while this is true. 
  # We call the method in a before_create filter so that the 
  # token is generated when a new user is saved for the first time. 
  # If we have pre-existing users in the database we’ll need to create 
  # tokens for them as we could create a rake task to do this, though 
  # we won’t do so here.

  before_create { generate_token(:auth_token)}

  def generate_token(column)
    p "Generating token for #{column}"
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  #NOTE
  # We don’t need to validate the presence of the password and password_confirmation fields, 
  #however, as this will be handled by has_secure_password.
end
