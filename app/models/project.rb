class Project < ActiveRecord::Base
  #### Relations ####
  has_many :collaborators
  has_many :users, through: :collaborators
  belongs_to :contractor
  belongs_to :sub_contractor

  #### Validations ####
  validates_presence_of :name, :contract_number, :budget, :init_date, :finish_date,
    :contractor_id, :address, :address_state, :address_municipality, :address_city
  validates_numericality_of :budget, :advance, :contractor_id, :latitude, :longitude
  validate :check_init_date


  private
    def check_init_date
      if (init_date.present? && finish_date.present?) && (init_date > finish_date)
        errors[:init_date] = "fecha de Inicio debe ser menor a fecha de Culminacion"
      end
    end
end
