class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  #### Relations ####
  has_many :collaborators
  has_many :projects, through: :collaborators
  belongs_to :company, polymorphic: true

end
