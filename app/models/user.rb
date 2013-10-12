class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  #### Constants ####
  USER_TYPE = { super_admin: "super_admin", admin: "admin", owner: "owner",
    regular: "regular" }

  #### Relations ####
  has_many :collaborators
  has_many :projects, through: :collaborators
  belongs_to :company, polymorphic: true

end
