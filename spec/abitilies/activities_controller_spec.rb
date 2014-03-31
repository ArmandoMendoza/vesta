require 'spec_helper'

describe ActivitiesController, type: :controller do

  def params
    { name: "Actividad Nro-1", description: "Descripcion de Actividad", init_date: Date.today,
      execution_time: 10, unit_execution_time: Activity::UNIT[:days] }
  end

  before do
    @contractor = Contractor.make!
    @sub_contractor = SubContractor.make!
    @project = Project.make!(contractor: @contractor, sub_contractor: @sub_contractor)
    @other_project = Project.make!
    # @inspector = User.make!(:contractor_regular, company: @contractor)
    # @residente = User.make!(:sub_contractor_regular, company: @sub_contractor)

    #
  end

  #### CONTRACTOR ####
  describe "Contractor Owner" do
    before do
      @contractor_owner = User.make!(:contractor_owner, company: @contractor)
      login @contractor_owner
    end

    describe "Read" do
      before do
        Activity.make!(project: @project)
        Activity.make!(project: @other_project)
      end
      it "can see all activities of his project from index" do
        get :index, project_id: @project.id
        expect(response.code).to eq("200")
        expect(assigns(:activities)).to eq(@project.activities.load.to_a)
      end
      it "can see all activities of other project from index" do
        get :index, project_id: @other_project.id
        expect(response.code).to eq("200")
        expect(assigns(:activities)).to eq(@other_project.activities.load.to_a)
      end
    end

    describe "Create" do
      it "can see a form to create an activity to his project" do
        get :new, project_id: @project.id
        expect(response.code).to eq("200")
      end
      it "can create an activity to his project" do
        post :create, activity: params, project_id: @project.id
        expect(response.code).to eq("302")
      end

      it "cannot see a form to create an activity to project of other company" do
        expect{
          get :new, project_id: @other_project.id
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot create an activity to other company project" do
        expect{
          post :create, activity: params, project_id: @other_project.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Update" do
      before do
        @activity = Activity.make!(project: @project)
        @other_activity = Activity.make!(project: @other_project)
      end

      it "cannot see update form for activity of other company project" do
        expect{
          get :edit, project_id: @other_project.id, id: @other_activity
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot update activity of other company project" do
        expect{
          patch :update, project_id: @other_project.id, activity: params, id: @other_activity
        }.to raise_error(CanCan::AccessDenied)
      end

      it "can see the update form for activity of his projects" do
        get :edit, project_id: @project.id, id: @activity
        expect(response.code).to eq("200")
        expect(assigns(:activity)).to eq(@activity)
      end
      it "can update activity of his projects" do
        patch :update, project_id: @project.id, activity: params, id: @activity
        expect(response.code).to eq("302")
        expect(assigns(:activity)).to eq(@activity)
      end
    end
  end

  #### SUBCONTRACTOR ####
  describe "SubContractor Owner" do
    before do
      @sub_contractor_owner = User.make!(:sub_contractor_owner, company: @sub_contractor)
      login @sub_contractor_owner
    end

    describe "Read" do
      before do
        Activity.make!(project: @project)
        Activity.make!(project: @other_project)
      end
      it "can see all activities of his project from index" do
        get :index, project_id: @project.id
        expect(response.code).to eq("200")
        expect(assigns(:activities)).to eq(@project.activities.load.to_a)
      end
      it "can't see project's activities of other company" do
        expect{
          get :index, project_id: @other_project.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Create" do
      it "can see a form to create an activity to his project" do
        get :new, project_id: @project.id
        expect(response.code).to eq("200")
      end
      it "can create an activity to his project" do
        post :create, activity: params, project_id: @project.id
        expect(response.code).to eq("302")
      end

      it "cannot see a form to create an activity to project of other company" do
        expect{
          get :new, project_id: @other_project.id
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot create an activity to other company project" do
        expect{
          post :create, activity: params, project_id: @other_project.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Update" do
      before do
        @activity = Activity.make!(project: @project)
        @other_activity = Activity.make!(project: @other_project)
      end

      it "cannot see update form for activity of other company project" do
        expect{
          get :edit, project_id: @other_project.id, id: @other_activity
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot update activity of other company project" do
        expect{
          patch :update, project_id: @other_project.id, activity: params, id: @other_activity
        }.to raise_error(CanCan::AccessDenied)
      end

      it "can see the update form for activity of his projects" do
        get :edit, project_id: @project.id, id: @activity
        expect(response.code).to eq("200")
        expect(assigns(:activity)).to eq(@activity)
      end
      it "can update activity of his projects" do
        patch :update, project_id: @project.id, activity: params, id: @activity
        expect(response.code).to eq("302")
        expect(assigns(:activity)).to eq(@activity)
      end
    end
  end

  ###REGULAR USERS
  describe "SubContractor Regular" do
    before do
      @sub_contractor_regular = User.make!(:sub_contractor_regular, company: @sub_contractor)
      login @sub_contractor_regular
    end

    describe "Read" do
      before do
        Activity.make!(project: @project)
        Activity.make!(project: @other_project)
      end
      it "cannot see activities of his project" do
        expect{
          get :index, project_id: @project.id
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot see activities of other project" do
        expect{
          get :index, project_id: @other_project.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Create" do
      it "cannot see the create form for activity of a project of other company" do
        expect{
          get :new, project_id: @other_project.id
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot create an activity to other company project" do
        expect{
          post :create, activity: params, project_id: @other_project.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Update" do
      before do
        @activity = Activity.make!(project: @project)
        @other_activity = Activity.make!(project: @other_project)
      end

      it "cannot see update form for activity of other company project" do
        expect{
          get :edit, project_id: @other_project.id, id: @other_activity
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot update activity of other company project" do
        expect{
          patch :update, project_id: @other_project.id, activity: params, id: @other_activity
        }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
