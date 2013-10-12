class Project < ActiveRecord::Base
  #### Relations ####
  has_many :collaborators
  has_many :users, through: :collaborators
  belongs_to :contractor
  belongs_to :sub_contractor
end
