class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]
  
  has_many :sent_requests, class_name: 'FriendRequest', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_requests, class_name: 'FriendRequest', foreign_key: 'receiver_id', dependent: :destroy 
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy

  #after_create :send_welcome_email

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
  #def self.new_with_session(params, session)
  #  super.tap do |user|
  #    if data = session[“devise.facebook_data”] && session[“devise.facebook_data”][“extra”][“raw_info”]
  #      user.email = data[“email”] if user.email.blank?
  #    end
  #  end
  #end
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

end
