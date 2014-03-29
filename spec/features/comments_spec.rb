require 'spec_helper'

describe "Comments" do

  describe "Activity Comments" do
    before do
      @admin = User.make!(:contractor_admin)
      @project = Project.make!(contractor: @admin.company)
      @activity = Activity.make!(project: @project)
      login @admin
    end

    describe "User visit an Activity" do

      it "show a form to create a commant" do
        visit project_activity_path(@project, @activity)
        expect(page).to have_selector('form#new_comment')
      end

      it "can create a comment", js: true do
        visit project_activity_path(@project, @activity)
        within('form#new_comment') do
          fill_in :comment_comment, with: "Good work guys!!!"
          find('#comment_comment').native.send_keys(:return)
        end
        within('table.table-comments') do
          expect(page).to have_content("Good work guys!!!")
          expect(page).to have_content(@admin.full_name)
        end
      end
    end
  end
end