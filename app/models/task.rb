class Task < ActiveRecord::Base
  #### Relations ####
  belongs_to :activity

  #### Validations ####
  validates_presence_of :description, :users
  has_and_belongs_to_many :users

  #### Scopes ####
  default_scope -> { order(:id) }

  #### Instance Methods ####

  def asign_to?(user)
    users.include?(user)
  end

  def mark
    toggle!(:completed)
  end

end
