require 'spec_helper'

describe "Tasks" do

  describe "Activity Tasks" do
    before do
      company = SubContractor.make!
      @owner = User.make!(:sub_contractor_owner, company: company)
      @regular = User.make!(:sub_contractor_regular, company: company)
      @project = Project.make!(sub_contractor: company)
      Collaborator.make!(:sub_contractor_residente, project: @project, user: @owner)
      Collaborator.make!(:sub_contractor_residente, project: @project, user: @regular)
      @activity = Activity.make!(project: @project)
      Follower.make!(:owner, user: @owner, activity: @activity)
      Follower.make!(:follower, user: @regular, activity: @activity)
      @task = Task.make!(activity: @activity, users: [@owner, @regular])
    end

    describe "User Owner" do
      before { login @owner }

      it "should see the list of tasks in the activity" do
        visit project_activity_path(@project, @activity)
        expect(page).to have_selector(".table-tasks")
        expect(page).to have_content(@task.description)
      end

      it "should create a new task", js: true do
        visit project_activity_path(@project, @activity)
        expect(page).to have_selector("form#new_task")
        # fill_in :task_description, with: "A new task for you."
        # select @regular.full_name, from: "task_user_ids", visible: false
        # find('#task_description').native.send_keys(:return)
        # within('.table-tasks') do
        #   expect(page).to have_content("A new task for you.
        #     [ asignada a: #{@owner.full_name} - #{@regular.full_name}")
        # end
      end

      it "Should change the state of task", js: true do
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

    describe "User Regular" do
      pending
    end
  end
end