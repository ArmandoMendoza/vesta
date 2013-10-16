class SubContractorsController < ApplicationController
  before_action :set_sub_contractor, except: [:index, :new, :create]
  before_action :set_sub_contractor_params, only: [:create, :update]

  def index
    @sub_contractors = SubContractor.all
  end

  def show
  end

  def edit
  end

  def new
    @sub_contractor = SubContractor.new
  end

  def create
    @sub_contractor = SubContractor.new(params[:sub_contractor])
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
    def set_sub_contractor
      @sub_contractor = SubContractor.find(params[:id])
    end

    def set_sub_contractor_params
      params[:sub_contractor] = params.require(:sub_contractor).permit!
    end
end