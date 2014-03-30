class TasksController < ApplicationController
  before_action :set_task_params, only: [:create, :update]
  before_action :get_parents
  before_action :get_activity, only: [:destroy, :mark]

  def create
    @task = @activity.tasks.create(params[:task])
  end

  def update
  end

  def destroy
    @activity.owner?(current_user) ? @task.destroy : render("error")
  end

  def mark
    @task.asign_to?(current_user) ? @task.mark : render("error")
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
end
