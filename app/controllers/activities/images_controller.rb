class Activities::ImagesController < ApplicationController
  before_action :set_image_params, only: [:create, :update]
  load_and_authorize_resource :project
  load_and_authorize_resource :activity, through: :project
  load_and_authorize_resource :image, through: :activity

  def index
  end

  def edit
  end

  def new
  end

  def create
    respond_to do |format|
      @image.uploaded_by = current_user.id
      if @activity.images << @image
        format.html { redirect_to [@project, @activity, :images] }
        format.js
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def update
    if @image.update(params[:image])
      redirect_to [@project, @activity, :images]
    else
      render :edit
    end
  end

  def destroy
    @image.destroy
    redirect_to [@project, @activity, :images]
  end

  private
    def set_image_params
      params[:image] = params.require(:image).permit(:description, :image_file)
    end
end