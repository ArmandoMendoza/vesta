class Task < ActiveRecord::Base
  #### Relations ####
  belongs_to :activity

  #### Validations ####
  validates_presence_of :description

  #### Scopes ####
  default_scope -> { order(:id) }

  #### Instance Methods ####

  def mark
    toggle!(:complete)
  end

end
