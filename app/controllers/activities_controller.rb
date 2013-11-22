class ActivitiesController < ApplicationController
  before_action :set_activity_params, only: [:create, :update]
  load_and_authorize_resource :project
  load_and_authorize_resource :activity, through: :project

  def index
  end

  def edit
  end

  def new
  end

  def create
    if @project.activities << @activity
      redirect_to [@project, :activities]
    else
      render :new
    end
  end

  def update
    if @activity.update(params[:activity])
      redirect_to [@project, :activities]
    else
      render :edit
    end
  end

  private
    def set_activity_params
      params[:activity] = params.require(:activity).permit! #temporal
    end
end