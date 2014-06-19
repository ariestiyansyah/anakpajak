class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :authentication_keys => [:login]

  has_many :questions
  has_many :answers
  has_many :articles
  has_many :rules
  has_many :quotes
  has_many :authorizations
  acts_as_followable
  acts_as_follower
  # validates_presence_of :username
  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }
  
  before_create :set_default_role
  belongs_to :role
  # For Facebook Login
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    authorization     = Authorization.find_by(:provider => auth.provider, :uid => auth.uid)
    if authorization
      return authorization.user
    else
      registered_user = User.find_by(:email => auth.info.email)
      if registered_user
        return registered_user
      else
        user                = User.create(username:auth.info.first_name, email:auth.info.email, password: Devise.friendly_token[0,20], confirmed_at: Time.now)
        user_authorization  = user.authorizations.create(uid:auth.uid, provider:auth.provider)
        user_authorization.user
      end
    end
  end
  # For Login Using Username
  attr_accessor :login

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  private
    def set_default_role
      self.role ||= Role.find_by_name('registered')
    end
end
