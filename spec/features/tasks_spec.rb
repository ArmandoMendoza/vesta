require 'spec_helper'

describe "Tasks" do

  describe "Activity Tasks" do
    before do
      @admin = User.make!(:contractor_admin)
      @project = Project.make!(contractor: @admin.company)
      @activity = Activity.make!(project: @project)
      login @admin
    end

    describe "User visit Activity" do

      it "should see the list of tasks in the activity" do
        task = Task.make!(activity: @activity)
        visit project_activity_path(@project, @activity)
        expect(page).to have_selector(".table-tasks")
        expect(page).to have_content(task.description)
      end

      it "should create a new task", js: true do
        visit project_activity_path(@project, @activity)
        fill_in :task_description, with: "A new task for you."
        click_button "Agregar"
        within('.table-tasks') do
          expect(page).to have_content('A new task for you.')
        end
      end

      pending('test a change the state of task')
    end
  end
end