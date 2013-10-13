class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  #### Constants ####
  USER_TYPE = { admin: "admin", owner: "owner", regular: "regular" }

  #### Relations ####
  has_many :collaborators
  has_many :projects, through: :collaborators
  belongs_to :company, polymorphic: true

  #### Callbacks ####
  before_save :set_user_type

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

  private
    def set_user_type
      self.user_type ||= USER_TYPE[:regular]
    end
end
