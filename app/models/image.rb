class Image < ActiveRecord::Base
  #### Extensions ####
  mount_uploader :image_file, ImageFileUploader

  #### Relations ####
  belongs_to :imageable, polymorphic: true

  #### Scopes #####
  default_scope -> { order('created_at DESC') }

  #### Callbacks ####
  before_save :set_description

  #### Instance Methods ####

  def uploaded_by_user
    User.find(uploaded_by)
  end

  private
    def set_description
      self.description = "imagen de actividad" if description.blank? || description.nil?
    end
end
