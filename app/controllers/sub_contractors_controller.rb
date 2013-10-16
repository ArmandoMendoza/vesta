class SubContractorsController < ApplicationController
  before_action :set_sub_contractor_params, only: [:create, :update]
  load_and_authorize_resource :sub_contractor

  def index
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
    if @sub_contractor.save
      redirect_to sub_contractor_path(@sub_contractor)
    else
      render :new
    end
  end

  def update
    if @sub_contractor.update(params[:sub_contractor])
      redirect_to sub_contractor_path(@sub_contractor)
    else
      render :edit
    end
  end

  private
    def set_sub_contractor_params
      params[:sub_contractor] = params.require(:sub_contractor).permit!
    end
end