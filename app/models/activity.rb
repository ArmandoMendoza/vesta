class Activity < ActiveRecord::Base
  #### Constants ####
  STATE = { executing: "executing", stopped: "stopped", finished: "finished" }
  UNIT = { hours: "hours", days: "days", weeks: "weeks", months: "months", years: "years" }
  TRANSLATED_UNITS = {
    I18n.t("execution_time_units.hours") => "hours",
    I18n.t("execution_time_units.days") => "days",
    I18n.t("execution_time_units.weeks") => "weeks",
    I18n.t("execution_time_units.months") => "months",
    I18n.t("execution_time_units.years") => "years",
  }

  #### Relations ####
  belongs_to :project
  has_many :executions

  #### Validations ####
  validates_presence_of :name, :init_date, :execution_time, :unit_execution_time
  validates_numericality_of :execution_time

  #### Callbacks ####
  before_create :set_finish_date, :set_defaults
  after_create :create_first_execution

  #### Instance Methods ####
  def executing?
    state == STATE[:executing]
  end

  def stopped?
    state == STATE[:stopped]
  end

  def finished?
    state == STATE[:finished]
  end

  def current_execution
    executions.last
  end

  def full_execution_time
    "#{execution_time} #{unit_execution_time}"
  end

  private
    def create_first_execution
      executions << Execution.new(percent: 0)
    end

    def set_finish_date
      self.finish_date ||= init_date + execution_time.send(unit_execution_time)
    end

    def set_defaults
      self.percent_of_the_project ||= 0
      self.state = STATE[:executing]
    end
end
