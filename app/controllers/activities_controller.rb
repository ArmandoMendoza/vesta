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
    if @project.collaborators << @collaborator
      redirect_to [@project, :collaborators]
    else
      render :new
    end
  end

  def update
    if @collaborator.update(params[:collaborator])
      redirect_to [@project, :collaborators]
    else
      render :edit
    end
  end

  private
    def set_collaborator_params
      params[:collaborator] = params.require(:collaborator).permit(:user_id, :collaborator_type)
    end
end