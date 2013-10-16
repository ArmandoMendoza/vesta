class SubContractor < ActiveRecord::Base
  #### Relations ####
  has_many :projects
  has_many :users, as: :company

  #### Validations ####
  validates_presence_of :name, :rif, :address, :email, :phone
  validates_format_of :rif, with: /\A[Jj][-{1}]\d+[-{1}]\d{1}\z/
  validates_format_of :phone, with: /\A\d{3}[-{1}]\d+\z/

  #### class Methods ####

  def self.collaboration_types
    ["Residente"]
  end
end
