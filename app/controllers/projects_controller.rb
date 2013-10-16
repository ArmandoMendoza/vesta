class ProjectsController < ApplicationController
  before_action :set_project_params, only: [:create, :update]
  load_and_authorize_resource :project

  def index
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def update
    if @project.update(params[:project])
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  private
    def set_project_params
      params[:project] = params.require(:project).permit!
    end
end

