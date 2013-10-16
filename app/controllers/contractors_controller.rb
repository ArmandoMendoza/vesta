class ContractorsController < ApplicationController
  before_action :set_contractor_params, only: [:create, :update]
  load_and_authorize_resource :contractor

  def index
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
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
    def set_contractor_params
      params[:contractor] = params.require(:contractor).permit!
    end
end
