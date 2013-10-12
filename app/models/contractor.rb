class Contractor < ActiveRecord::Base
  #### Relations ####
  has_many :projects
  has_many :users, as: :company
end
