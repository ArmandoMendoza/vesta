class Image < ActiveRecord::Base
  #### Extensions ####
  mount_uploader :image_file, ImageFileUploader

  #### Relations ####
  belongs_to :imageable, polymorphic: true
end
