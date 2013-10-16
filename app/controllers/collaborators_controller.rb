class CollaboratorsController < ApplicationController
  before_action :get_project
  before_action :get_collaborator, only: [:edit, :update]
  before_action :set_collaborator_params, only: [:create, :update]
  before_action :get_select_options, only: [:new, :create, :edit, :update]

  def index
    @collaborators = @project.collaborators
  end

  def edit
  end

  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new(params[:collaborator])
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
    def get_project
      @project ||= Project.find(params[:project_id])
    end

    def get_select_options
      @users = current_user.company.users
      @collaboration_types = current_user.company.class.collaboration_types
    end

    def get_collaborator
      @collaborator ||= @project.collaborators.find(params[:id])
    end

    def set_collaborator_params
      params[:collaborator] = params.require(:collaborator).permit(:user_id, :collaborator_type)
    end
end
