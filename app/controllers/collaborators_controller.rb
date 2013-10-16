class CollaboratorsController < ApplicationController
  before_action :set_collaborator_params, only: [:create, :update]
  before_action :get_select_options, only: [:new, :create, :edit, :update]
  load_and_authorize_resource :project
  load_and_authorize_resource :collaborator, :through => :project

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
    def get_select_options
      @users = current_user.company.users
      @collaboration_types = current_user.company.class.collaboration_types
    end

    def set_collaborator_params
      params[:collaborator] = params.require(:collaborator).permit(:user_id, :collaborator_type)
    end
end
