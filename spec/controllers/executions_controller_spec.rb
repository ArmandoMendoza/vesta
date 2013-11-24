require 'spec_helper'

describe ExecutionsController do

  describe "POST 'create'" do
    it "create a new execution to activity and redirect to last page" do
      login_admin
      project = Project.make!(contractor: @admin.company)
      activity = Activity.make!(project: project)
      request.env["HTTP_REFERER"] = project_activity_path(project, activity)
      expect {
        post :create, project_id: project.id, activity_id: activity.id, execution: { percent: 20 }
      }.to change(Execution, :count).by(1)
      expect(Execution.last.percent).to eq(20)
      expect(Execution.last.date).to eq(Date.today)
      expect(Execution.last.activity_id).to eq(activity.id)
      expect(assigns(:project)).to eq(project)
      expect(assigns(:activity)).to eq(activity)
      expect(response).to redirect_to project_activity_path(project, activity)
    end
  end

end
