class TasksController < ApplicationController
  before_action :set_task_params, only: [:create, :update]
  before_action :get_parents
  before_action :get_activity, only: [:destroy, :mark]
  before_action :check_user

  def create
    @task = @activity.tasks.create(params[:task])
  end

  def update
  end

  def destroy
    @task.destroy
  end

  def mark
    @task.mark
  end

  private
    def get_parents
      @project ||= Project.find(params[:project_id])
      @activity ||= @project.activities.find(params[:activity_id])
    end

    def get_activity
      @task ||= @activity.tasks.find(params[:id])
    end

    def set_task_params
      params[:task] = params.require(:task).permit!
    end

    def check_user
      render "error" unless @task.asign_to?(current_user)
    end
end
