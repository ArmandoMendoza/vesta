class Image < ActiveRecord::Base
  #### Extensions ####
  mount_uploader :image_file, ImageFileUploader

  #### Relations ####
  belongs_to :imageable, polymorphic: true

  #### Callbacks ####
  before_save :set_description

  private
    def set_description
      self.description = "imagen de actividad" if description.blank? || description.nil?
    end
end
