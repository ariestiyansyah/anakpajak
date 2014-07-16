class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

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
  
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  before_create :set_default_role
  belongs_to :role
  # For Facebook Login
  # def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  #   authorization     = Authorization.find_by(:provider => auth.provider, :uid => auth.uid)
  #   if authorization
  #     return authorization.user
  #   else
  #     registered_user = User.find_by(:email => auth.info.email)
  #     if registered_user
  #       return registered_user
  #     else
  #       user                = User.create(username:auth.info.first_name, email:auth.info.email, password: Devise.friendly_token[0,20], confirmed_at: Time.now)
  #       user_authorization  = user.authorizations.create(uid:auth.uid, provider:auth.provider)
  #       user_authorization.user
  #     end
  #   end
  # end
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Authorization.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          username: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
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
