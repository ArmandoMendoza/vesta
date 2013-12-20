class Project < ActiveRecord::Base
  #### Constants ####
  STATE = { executing: "executing", stopped: "stopped", finished: "finished" }

  #### Relations ####
  has_many :collaborators
  has_many :activities
  has_many :users, through: :collaborators
  belongs_to :contractor
  belongs_to :sub_contractor

  #### Validations ####
  validates_presence_of :name, :contract_number, :budget, :init_date, :finish_date,
    :contractor_id, :address, :address_state, :address_municipality, :address_city
  validates_numericality_of :budget, :advance, :contractor_id, :latitude, :longitude
  validate :check_init_date

  #### Callbacks ####
  before_validation :set_defaults
  before_create :set_state

  #### Instance Methods ####
  def role_of(user)
    collaborators.where(user_id: user.id).first.try(:collaborator_type)
  end

  def list_of_users_without(user = nil)
    array_of_collaborators = users.to_a
    array_of_collaborators.delete(user)
    array_of_collaborators
  end

  private
    def set_defaults
      self.advance ||= 0
      self.latitude ||= 0
      self.longitude ||= 0
    end

    def set_state
      self.state = STATE[:executing]
    end

    def check_init_date
      if (init_date.present? && finish_date.present?) && (init_date > finish_date)
        errors[:init_date] = "fecha de Inicio debe ser menor a fecha de Culminacion"
      end
    end
end
