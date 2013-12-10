require 'spec_helper'

describe "Images" do

  describe "Activity Images" do
    before do
      @admin = User.make!(:contractor_admin)
      @project = Project.make!(contractor: @admin.company)
      @activity = Activity.make!(project: @project)
      login @admin
    end

    describe "User visit Index" do

      it "should see a thumbnails of images of activity" do
        image = Image.make!(:activity, imageable: @activity)
        visit project_activity_images_path(@project, @activity)
        expect(page).to have_selector(".thumbnail")
        expect(page).to have_content(image.description)
      end

      it "should upload images using jquery upload plugin", js: true do
        visit project_activity_images_path(@project, @activity)
        attach_file 'image_image_file', fixture_path + "/image.jpg"
        expect(page).to have_content('imagen de actividad')
        expect(@activity.images.last.uploaded_by).to eq(@admin.id)
      end
    end
  end
end