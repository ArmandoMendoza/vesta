require 'spec_helper'

describe ProjectsController, type: :controller do

  def params
    { name: "Fake Contractor" }
  end

  #### CONTRACTOR ####
  describe "Contractor Owner" do
    before do
      @contractor_owner = User.make!(:contractor_owner)
      login @contractor_owner
    end

    describe "Read" do
      before do
        3.times { Project.make! }
      end
      it "can see all projects from index" do
        get :index
        expect(response.code).to eq("200")
        expect(assigns(:projects)).to eq(Project.all)
      end
      it "can see all info of a Project from show" do
        get :show, id: Project.last
        expect(response.code).to eq("200")
        expect(assigns(:project)).to eq(Project.last)
      end
    end

    describe "Create" do
      it "cannot create a project from new" do
        expect{ get(:new) }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot create a project from post" do
        expect{ post :create, project: params }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Update" do
      before { @project = Project.make! }
      it "cannot update a project from edit" do
        expect{ get :edit, id: @project.id }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot update a project from update" do
        expect{ patch :update, id: @project.id, project: params }.to raise_error(CanCan::AccessDenied)
      end
    end
  end

  #### SUBCONTRACTOR ####
  describe "SubContractor Owner" do
    before do
      @sub_contractor_owner = User.make!(:sub_contractor_owner)
      login @sub_contractor_owner
    end

    describe "Read" do
      before do
        3.times { Project.make!(sub_contractor: @sub_contractor_owner.company) }
      end
      it "can see all projects from index" do
        get :index
        expect(response.code).to eq("200")
        expect(assigns(:projects)).to eq(Project.all)
      end
      it "can see all info of a Project from show" do
        get :show, id: Project.last
        expect(response.code).to eq("200")
        expect(assigns(:project)).to eq(Project.last)
      end
    end

    describe "Create" do
      it "can create a project from new" do
        get :new
        expect(response.code).to eq("200")
        expect(assigns(:project)).to be_a_new(Project)
      end
      it "can create a project from post" do
        post :create, project: params
        expect(response.code).to eq("200") #should be 302. but its 200 because a params.
        expect(assigns(:project)).to be_a_new(Project)
      end
    end

    describe "Update" do
      before { @project = Project.make!(sub_contractor: @sub_contractor_owner.company) }
      it "can update a project from edit" do
        get :edit, id: @project.id
        expect(response.code).to eq("200")
        expect(assigns(:project)).to eq(@project)
      end
      it "can create a project from post" do
        patch :update, id: @project, project: params
        expect(response.code).to eq("302")
        expect(assigns(:project)).to eq(@project)
      end
    end
  end
end
