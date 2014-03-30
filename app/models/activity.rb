class Activity < ActiveRecord::Base
  #### Extensions ####
  include ActsAsTree
  extend ActsAsTree::Presentation
  acts_as_tree order: "name"
  acts_as_commentable

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
  has_many :followers
  has_many :tasks
  has_many :users, through: :followers
  has_many :images, as: :imageable


  #### Validations ####
  validates_presence_of :name, :init_date, :execution_time, :unit_execution_time
  validates_numericality_of :execution_time

  #### Callbacks ####
  before_create :set_finish_date, :set_defaults
  after_create :create_first_execution

  #### Instance Methods ####
  def role_of(user)
    followers.where(user_id: user.id).first.try(:role)
  end

  def owner?(user)
    role_of(user) == Follower::ROLES[:owner]
  end

  def is_active?
    has_parent? ? parent_finished? : true
  end

  def has_parent?
    parent.present?
  end

  def parent_finished?
    parent.finished?
  end

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
    "#{execution_time} #{TRANSLATED_UNITS.key(unit_execution_time)}"
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
