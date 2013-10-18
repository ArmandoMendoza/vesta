require 'spec_helper'

describe CollaboratorsController, type: :controller do

  def params
    { user_id: 1, collaborator_type: "Residente" }
  end

  before do
    @contractor = Contractor.make!
    @sub_contractor = SubContractor.make!
    @inspector = User.make!(:contractor_regular, company: @contractor)
    @residente = User.make!(:sub_contractor_regular, company: @sub_contractor)
    @project = Project.make!(contractor: @contractor, sub_contractor: @sub_contractor)
    @other_project = Project.make!
  end

  #### CONTRACTOR ####
  describe "Contractor Owner" do
    before do
      @contractor_owner = User.make!(:contractor_owner, company: @contractor)
      login @contractor_owner
    end

    describe "Read" do
      before do
        Collaborator.make!(:contractor_inspector, project: @project)
        Collaborator.make!(:contractor_inspector, project: @other_project)
      end
      it "can see all collaborator of his project from index" do
        get :index, project_id: @project.id
        expect(response.code).to eq("200")
        expect(assigns(:collaborators)).to eq(@project.collaborators.load.to_a)
      end
      it "can see all collaborators of other project from index" do
        get :index, project_id: @other_project.id
        expect(response.code).to eq("200")
        expect(assigns(:collaborators)).to eq(@other_project.collaborators.load.to_a)
      end
    end

    describe "Create" do
      it "can create a collaborator to his project from new" do
        get :new, project_id: @project.id
        expect(response.code).to eq("200")
      end
      it "can create a collaborator to his project from post" do
        post :create, collaborator: params, project_id: @project.id
        expect(response.code).to eq("302")
      end

      it "cannot create a collaborator on the project from new" do
        expect{
          get :new, project_id: @other_project.id
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot create a collaborator on the project from post" do
        expect{
          post :create, collaborator: params, project_id: @other_project.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Update" do
      before do
        @collaborator = Collaborator.make!(:contractor_inspector, project: @project,
          user: @inspector)
        @other_collaborator = Collaborator.make!(:contractor_inspector, project: @other_project)
      end
      it "cannot update collaborator of other project from edit" do
        expect{
          get :edit, project_id: @other_project.id, id: @other_collaborator
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot update collaborator of other project from update" do
        expect{
          patch :update, project_id: @other_project.id, collaborator: params, id: @other_collaborator
        }.to raise_error(CanCan::AccessDenied)
      end

      it "can update collaborators of his projects from edit" do
        get :edit, project_id: @project.id, id: @collaborator
        expect(response.code).to eq("200")
        expect(assigns(:collaborator)).to eq(@collaborator)
      end
      it "can update collaborators of his projects from update" do
        patch :update, project_id: @project.id, collaborator: params, id: @collaborator
        expect(response.code).to eq("302")
        expect(assigns(:collaborator)).to eq(@collaborator)
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
        Collaborator.make!(:contractor_inspector, project: @project)
        Collaborator.make!(:contractor_inspector, project: @other_project)
      end
      it "can see all collaborator of his project from index" do
        get :index, project_id: @project.id
        expect(response.code).to eq("200")
        expect(assigns(:collaborators)).to eq(@project.collaborators.load.to_a)
      end
      it "can see all collaborators of other project from index" do
        get :index, project_id: @other_project.id
        expect(response.code).to eq("200")
        expect(assigns(:collaborators)).to eq(@other_project.collaborators.load.to_a)
      end
    end

    describe "Create" do
      it "can create a collaborator to his project from new" do
        get :new, project_id: @project.id
        expect(response.code).to eq("200")
      end
      it "can create a collaborator to his project from post" do
        post :create, collaborator: params, project_id: @project.id
        expect(response.code).to eq("302")
      end

      it "cannot create a collaborator on the project from new" do
        expect{
          get :new, project_id: @other_project.id
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot create a collaborator on the project from post" do
        expect{
          post :create, collaborator: params, project_id: @other_project.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Update" do
      before do
        @collaborator = Collaborator.make!(:contractor_inspector, project: @project,
          user: @residente)
        @other_collaborator = Collaborator.make!(:contractor_inspector, project: @other_project)
      end
      it "cannot update collaborator of other project from edit" do
        expect{
          get :edit, project_id: @other_project.id, id: @other_collaborator
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot update collaborator of other project from update" do
        expect{
          patch :update, project_id: @other_project.id, collaborator: params, id: @other_collaborator
        }.to raise_error(CanCan::AccessDenied)
      end

      it "can update collaborators of his projects from edit" do
        get :edit, project_id: @project.id, id: @collaborator
        expect(response.code).to eq("200")
        expect(assigns(:collaborator)).to eq(@collaborator)
      end
      it "can update collaborators of his projects from update" do
        patch :update, project_id: @project.id, collaborator: params, id: @collaborator
        expect(response.code).to eq("302")
        expect(assigns(:collaborator)).to eq(@collaborator)
      end
    end
  end
end
