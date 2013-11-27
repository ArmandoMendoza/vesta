require 'spec_helper'

describe "Images" do
  before do
    @admin = User.make!(:contractor_admin)
    @project = Project.make!(contractor: @admin.company)
    @activity = Activity.make!(project: @project)
    login @admin
  end

  it "Should work" do
    visit project_activity_images_path(@project, @activity)
    expect(page).to have_content("index")
  end
end