class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  has_many :questions
  has_many :answers
  has_many :articles
  # validates_presence_of :username
  validates :username,
  :uniqueness => {
    :case_sensitive => false
  }
  
  before_create :set_default_role
  belongs_to :role

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
