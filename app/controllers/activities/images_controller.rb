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
    if @activity.images << @image
      redirect_to [@project, @activity, :images]
    else
      render :new
    end
  end

  def update
    if @image.update(params[:image])
      redirect_to [@project, @activity, :images]
    else
      render :edit
    end
  end

  private
    def set_image_params
      params[:image] = params.require(:image).permit!
    end
end