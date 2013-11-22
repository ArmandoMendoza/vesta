class Execution < ActiveRecord::Base
  #### Relations ####
  belongs_to :activity

  #### Validations ####
  validates_presence_of :percent
  validates_numericality_of :percent

  #### Callbacks ####
  before_create :set_date

  private
    def set_date
      self.date ||= Date.today
    end
end