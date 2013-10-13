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
    @contractor = Contractor.new
  end

  def create
    @contractor = Contractor.new(contractor_params)
    if @contractor.save
      redirect_to contractor_path(@contractor)
    else
      render :new
    end
  end

  def update
    if @contractor.update(contractor_params)
      redirect_to contractor_path(@contractor)
    else
      render :edit
    end
  end

  private
    def set_contractor
      @contractor = Contractor.find(params[:id])
    end
    def contractor_params
      params.require(:contractor).permit(:name, :rif, :address, :phone, :email)
    end
end
