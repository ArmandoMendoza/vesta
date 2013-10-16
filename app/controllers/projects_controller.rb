class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]
  before_action :set_project_params, only: [:create, :update]


  def index
    @projects = Project.all
  end

  def show
  end

  def edit
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
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
    def set_project
      @project = Project.find(params[:id])
    end

    def set_project_params
      params[:project] = params.require(:project).permit!
    end
end

