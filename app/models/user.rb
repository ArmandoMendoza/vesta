class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  #### Constants ####
  USER_TYPE = { admin: "admin", owner: "owner", regular: "regular" }

  #### Relations ####
  has_many :collaborators
  has_many :followers
  has_many :projects, through: :collaborators
  belongs_to :company, polymorphic: true

  #### Validations ###
  validates_presence_of :first_name, :last_name, :user_type

  #### Callbacks ####
  before_validation :set_user_type

  #### Instance Methods ####

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    user_type == USER_TYPE[:admin]
  end

  def owner?
    user_type == USER_TYPE[:owner]
  end

  def regular?
    user_type == USER_TYPE[:regular]
  end

  def company_type
    company.class.to_s if company.present?
  end

  private
    def set_user_type
      self.user_type ||= USER_TYPE[:regular]
    end
end
