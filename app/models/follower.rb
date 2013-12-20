class Follower < ActiveRecord::Base
  #### Constanst ####
  ROLES = {owner: "owner", follower: "seguidor"}

  #### Relations ####
  belongs_to :user
  belongs_to :activity

  #### Validations ####
  # validates_presence_of :activity_id, :user_id
  # validates_uniqueness_of :user_id, scope: :activity_id

  #### Callback ####
  before_save :set_role_default

  ### class Methods ###

  def self.create_owner_to_activity(user, activity)
    create(user_id: user.id, activity_id: activity.id, role: ROLES[:owner])
  end

  private
    def set_role_default
      self.role = ROLES[:follower] if role.blank? || role.nil?
    end
end
