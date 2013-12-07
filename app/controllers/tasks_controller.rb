class TasksController < ApplicationController
  before_action :set_task_params, only: [:create, :update]
  before_action :get_parents

  def create
    @task = @activity.tasks.create(params[:task])
  end

  def update
  end

  private
    def get_parents
      @project ||= Project.find(params[:project_id])
      @activity ||= @project.activities.find(params[:activity_id])
    end

    def set_task_params
      params[:task] = params.require(:task).permit!
    end
end
