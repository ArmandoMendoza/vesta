class ContractorsController < ApplicationController
  before_action :set_contractor, except: [:index, :new, :create]
  before_action :set_contractor_params, only: [:create, :update]

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
    @contractor = Contractor.new(params[:contractor])
    if @contractor.save
      redirect_to contractor_path(@contractor)
    else
      render :new
    end
  end

  def update
    if @contractor.update(params[:contractor])
      redirect_to contractor_path(@contractor)
    else
      render :edit
    end
  end

  private
    def set_contractor
      @contractor = Contractor.find(params[:id])
    end

    def set_contractor_params
      params[:contractor] = params.require(:contractor).permit!
    end
end
