class User < ApplicationRecord
  has_secure_password

  has_many :payees
  has_many :attendees
  has_many :expenses
  has_many :trips, :through => :attendees

  validates :name, presence: true, length: { minimum: 1, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials( email, password )
    user = User.find_by_email(email.strip.downcase)
    if !user
      return nil
    elsif user.authenticate(password)
      return user
    else
      return nil
    end
  end

end
