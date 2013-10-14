require 'spec_helper'

describe Project do

  it { should belong_to(:contractor) }
  it { should belong_to(:sub_contractor) }
  it { should have_many(:collaborators) }
  it { should have_many(:users).through(:collaborators) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:contract_number) }
  it { should validate_presence_of(:budget) }
  it { should validate_presence_of(:init_date) }
  it { should validate_presence_of(:finish_date) }
  it { should validate_presence_of(:contractor_id) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:address_city) }
  it { should validate_presence_of(:address_municipality) }
  it { should validate_presence_of(:address_state) }

  it { should validate_numericality_of(:budget) }
  it { should validate_numericality_of(:advance) }
  it { should validate_numericality_of(:latitude) }
  it { should validate_numericality_of(:longitude) }
  it { should validate_numericality_of(:contractor_id) }

  describe "Custom validations" do
    it "should be invalid if init_date > finish_date" do
      project = Project.make(init_date: (Date.today + 10), finish_date: Date.today)
      expect(project).not_to be_valid
      expect(project).to have(1).errors
      expect(project.error_on(:init_date)).to include("fecha de Inicio debe ser menor a fecha de Culminacion")
    end
  end

end
# otro_consumo.should have(1).error_on(:nro_documento)
# otro_consumo.errors_on(:nro_documento).should include(I18n.t("errors.messages.taken"))
