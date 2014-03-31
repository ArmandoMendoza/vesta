require 'spec_helper'

describe SubContractorsController, type: :controller do

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
        3.times { SubContractor.make! }
      end
      it "can see all subcontractors from index" do
        get :index
        expect(response.code).to eq("200")
        expect(assigns(:sub_contractors)).to eq(SubContractor.all)
      end
      it "can see all info of a subcontractor from show" do
        get :show, id: SubContractor.last
        expect(response.code).to eq("200")
        expect(assigns(:sub_contractor)).to eq(SubContractor.last)
      end
    end

    describe "Create" do
      it "cannot create a sub_contractor from new" do
        expect{ get(:new) }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot create a sub_contractor from post" do
        expect{ post :create, sub_contractor: params }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Update" do
      before { @sub_contractor = SubContractor.make! }
      it "cannot update other sub_contractor from edit" do
        expect{ get :edit, id: @sub_contractor.id }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot update other sub_contractor from update" do
        expect{ patch :update, id: @sub_contractor.id, sub_contractor: params }.to raise_error(CanCan::AccessDenied)
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
        3.times { SubContractor.make! }
      end
      it "can see only your own company" do
        get :index
        expect(response.code).to eq("200")
        expect(assigns(:sub_contractors)).to eq([@sub_contractor_owner.company])
      end
      it "can see only the info of your own company" do
        get :show, id: @sub_contractor_owner.company
        expect(response.code).to eq("200")
        expect(assigns(:sub_contractor)).to eq(@sub_contractor_owner.company)
      end

      it "can't see the info of other company" do
        expect{ get :show, id: SubContractor.last }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Create" do
      it "cannot create a sub contractor from new" do
        expect{ get(:new) }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot create a sub contractor from post" do
        expect{ post :create, sub_contractor: params }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Update" do
      before { @sub_contractor = SubContractor.make! }
      it "cannot update a sub contractor from edit" do
        expect{ get :edit, id: @sub_contractor.id }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot update a sub contractor from patch" do
        expect{patch :update, id: @sub_contractor.id, sub_contractor: params }.to raise_error(CanCan::AccessDenied)
      end

      it "can update his subcontractor from edit" do
        get :edit, id: @sub_contractor_owner.company.id
        expect(response.code).to eq("200")
        expect(assigns(:sub_contractor)).to eq(@sub_contractor_owner.company)
      end
      it "can update his subcontractor from update" do
        patch :update, id: @sub_contractor_owner.company.id, sub_contractor: params
        expect(response.code).to eq("302")
        expect(assigns(:sub_contractor)).to eq(@sub_contractor_owner.company)
      end
    end
  end
end
