require 'spec_helper'

describe ContractorsController, type: :controller do

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
        3.times { Contractor.make! }
      end
      it "can see all contractors from index" do
        get :index
        expect(response.code).to eq("200")
        expect(assigns(:contractors)).to eq(Contractor.all)
      end
      it "can see all info of a contractor from show" do
        get :show, id: Contractor.last
        expect(response.code).to eq("200")
        expect(assigns(:contractor)).to eq(Contractor.last)
      end
    end

    describe "Create" do
      it "cannot create a contractor from new" do
        expect{ get(:new) }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot create a contractor from post" do
        expect{ post :create, contractor: params }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Update" do
      before { @contractor = Contractor.make! }
      it "cannot update other contractor from edit" do
        expect{ get :edit, id: @contractor.id }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot update other contractor from update" do
        expect{ patch :update, id: @contractor.id, contractor: params }.to raise_error(CanCan::AccessDenied)
      end

      it "can update his contractor from edit" do
        get :edit, id: @contractor_owner.company.id
        expect(response.code).to eq("200")
        expect(assigns(:contractor)).to eq(@contractor_owner.company)
      end
      it "can update his contractor from update" do
        patch :update, id: @contractor_owner.company.id, contractor: params
        expect(response.code).to eq("302")
        expect(assigns(:contractor)).to eq(@contractor_owner.company)
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
        3.times { Contractor.make! }
      end
      it "can see all contractors from index" do
        get :index
        expect(response.code).to eq("200")
        expect(assigns(:contractors)).to eq(Contractor.all)
      end
      it "can see all info of a contractor from show" do
        get :show, id: Contractor.last
        expect(response.code).to eq("200")
        expect(assigns(:contractor)).to eq(Contractor.last)
      end
    end

    describe "Create" do
      it "cannot create a contractor from new" do
        expect{ get(:new) }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot create a contractor from post" do
        expect{ post :create, contractor: params }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Update" do
      before { @contractor = Contractor.make! }
      it "cannot update a contractor from edit" do
        expect{ get :edit, id: @contractor.id }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot update a contractor from patch" do
        expect{patch :update, id: @contractor.id, contractor: params }.to raise_error(CanCan::AccessDenied)
      end
    end
  end
end
