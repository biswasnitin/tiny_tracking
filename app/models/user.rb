class User < ApplicationRecord
	has_many :user_track_logs

	 attr_accessor :password
  validates_confirmation_of :password
  validates :name, uniqueness: true
  validates :name, presence: true
  validates :name, format: { with: /\A[a-zA-Z0-9]+\Z/, message: "Special Character and White space are not allowed" }
  before_save :encript_password
  before_create {generate_token(:auth_token)}


  def encript_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
  end

  def self.authenticate(email,password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
      user
    else
      nil
    end
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!


  end

  def generate_token(column)
    begin
    self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column =>self[column])
  end
end
