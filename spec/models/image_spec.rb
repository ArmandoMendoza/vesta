require 'spec_helper'

describe Image do
  describe "ImageFileUploader" do
    it "should store a file" do
      image = Image.new(description: "Description of image...")
      image.image_file = File.open(fixture_path + "/image.jpg")
      image.save
      expect(image.image_file.url).to eq("/uploads/image/image_file/#{image.id}/image.jpg")
      expect(image.image_file.current_path).to eq(Rails.root.to_s +
        "/public/uploads/image/image_file/#{image.id}/image.jpg")
      expect(image.image_file.identifier).to eq('image.jpg')
      expect(image.publish).to be_false
      expect(image.uploaded_by).to be_nil
    end
  end
end
