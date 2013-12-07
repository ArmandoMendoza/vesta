class TasksController < ApplicationController
  before_action :set_task_params, only: [:create, :update]
  before_action :get_parents

  def create
    @task = @activity.tasks.create(params[:task])
  end

  def update
  end

  def destroy
    @task = @activity.tasks.find(params[:id])
    @task.destroy
  end

  def mark
    @task = @activity.tasks.find(params[:id])
    @task.mark
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
