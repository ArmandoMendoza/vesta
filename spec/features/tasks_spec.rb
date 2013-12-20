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
        find('#task_description').native.send_keys(:return)
        within('.table-tasks') do
          expect(page).to have_content('A new task for you.')
        end
      end
    end

    describe "User mark as completed an a task", js: true do
      before do
        @task = Task.make!(activity: @activity)
      end

      it "Should change the state of task" do
        visit project_activity_path(@project, @activity)
        row = find("#task-#{@task.id}")
        within('.table-tasks') do
          row.find(".mark-task").click
        end
        expect(page).to have_selector("#task-#{@task.id}.task-completed")
        @task.reload
        expect(@task).to be_completed
      end
    end
  end
end