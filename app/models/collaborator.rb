class Collaborator < ActiveRecord::Base
  #### Relations ####
  belongs_to :user
  belongs_to :project

  #### Validations ####
  validates_presence_of :project_id, :user_id, :collaborator_type
  validates_uniqueness_of :collaborator_type, scope: :project_id
end
