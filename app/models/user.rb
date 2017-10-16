class User < ApplicationRecord

  has_secure_password

  has_many :reviews

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 8 }

  before_save { self.email.downcase! unless self.email.blank? }

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by(email: email.strip.downcase)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

end
