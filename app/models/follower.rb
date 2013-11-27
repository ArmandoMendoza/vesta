class Follower < ActiveRecord::Base
  #### Relations ####
  belongs_to :user
  belongs_to :activity

  #### Validations ####
  validates_presence_of :activity_id, :user_id
  validates_uniqueness_of :user_id, scope: :activity_id
end
