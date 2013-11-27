class Execution < ActiveRecord::Base
  #### Relations ####
  belongs_to :activity

  #### Validations ####
  validates_presence_of :percent
  validates_numericality_of :percent

  #### Callbacks ####
  before_create :set_date
  after_create  :change_state_of_activity

  private
    def set_date
      self.date ||= Date.today
    end

    def change_state_of_activity
      if activity.present? && percent == 100
        activity.update_column(:state, Activity::STATE[:finished])
      end
    end
end