class User < ApplicationRecord
  # Because some database adapters are case sensitive, we use the before_save callback to make sure all emails coming in to this model are downcased before being saved to the database.
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # requires that we add a password_digest attribute to the user model (so, we create a migration that adds a password_digest column to the Users DB table), and that we have bcrypt gem in our Gemfile. This adds virtual password and password_confirmation attributes to the User model that must be passed in upon creating a User. So, the tests you have setup will fail when you include this function the first time. To get them to pass, add password and password_confirmation fields to the creation of a User (and, of course, make sure they match!)
  has_secure_password

  # Make sure the password is present and is at least 6 characters long. You don't have to validate the password_confirmation attribute, since it must match the password this is already taken care of.
  validates :password, presence: true, length: { minimum: 6 }
end
