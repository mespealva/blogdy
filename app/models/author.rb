class Author < ApplicationRecord
  #after_create { AuthorNotifierMailer.send_signup_email.deliver}
  has_many :posts, dependent: :destroy
  acts_as_voter
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :validatable, :omniauthable, 
         omniauth_providers: [:google_oauth2]
  
  validates :full_name, presence: true
  validates :avatar_url, presence: true

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url, password: Devise.friendly_token[0,20]).find_or_create_by!(email: email)
  end

  def is_admin?
    if self.id == 1
        return true
    end
  end

  
end

