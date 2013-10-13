class ContractorsController < ApplicationController
  before_action :set_contractor, except: [:index, :new, :create]
  def index
    @contractors = Contractor.all
  end

  def show
  end

  def edit
  end

  def new
  end

  private
    def set_contractor
      @contractor = Contractor.find(params[:id])
    end
    def contractor_params
      params.require(contractor).permit(:name, :rif, :address, :phone, :email)
    end
end
