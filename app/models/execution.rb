class Execution < ActiveRecord::Base
  #### Relations ####
  belongs_to :activity

  #### Validations ####
  validates_presence_of :date, :percent
  validates_numericality_of :percent

  #### Callbacks ####
  before_create :set_defaults

  private
    def set_defaults
      self.date ||= Date.today
    end

end
