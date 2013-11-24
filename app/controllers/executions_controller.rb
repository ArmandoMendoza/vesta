class ExecutionsController < ApplicationController
  before_action :set_execution_params, only: :create
  before_action :get_project_and_activity
  authorize_resource

  def create
    @execution = Execution.new(params[:execution])

    respond_to do |format|
      if @activity.executions << @execution
        format.html { redirect_to :back, notice: "Ejecucion actualizada" }
        format.js
      else
        format.html { redirect_to :back, notice: "Error al actualizar Ejecucion" }
        format.js
      end
    end
  end

  private
    def get_project_and_activity
      @project = Project.find(params[:project_id]) if params[:project_id].present?
      @activity = @project.activities.find(params[:activity_id]) if params[:activity_id].present? && @project.present?
    end

    def set_execution_params
      params[:execution] = params.require(:execution).permit(:percent)
    end
end
