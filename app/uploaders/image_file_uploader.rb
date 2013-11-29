# encoding: utf-8
class ImageFileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  # process resize_to_fill: [200, 200]

  version :index_thumb do
    process resize_to_fill: [300, 200]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
