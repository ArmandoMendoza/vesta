class Activities::CommentsController < ApplicationController
  before_action :set_comment_params, only: :create
  before_action :get_parents

  def create
    @comment = @activity.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
      redirect_to :back, notice: 'Thank you, your comment has been recorded.'
    else
      render :new
    end
  end

  def destroy
    @comment = @activity.comments.find(params[:id])
    @comment.destroy
  end

  private
    def get_parents
      @project ||= Project.find(params[:project_id])
      @activity ||= @project.activities.find(params[:activity_id])
    end

    def set_comment_params
      params[:comment] = params.require(:comment).permit(:comment)
    end
end
