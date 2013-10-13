require 'spec_helper'

describe UsersController do
  before do
    @contractor = Contractor.make!
    @sub_contractor = SubContractor.make!
    3.times do
      User.make!(:contractor_regular, company: @contractor)
      User.make!(:sub_contractor_regular, company: @sub_contractor)
    end
  end


  describe "GET 'index'" do
    context "User is Admin" do
      login_admin
      it "Should see all users of a contractor or sub_contractor" do
        get :index, contractor_id: @contractor
        expect(response.code).to eq("200")
        expect(assigns(:users)).to eq(@contractor.users)
      end
    end

    context "User is Contractor Owner" do
      login_contractor_owner(@contractor)
      it "Should see all users of a contractor or sub_contractor" do
        get :index, contractor_id: @contractor
        expect(response.code).to eq("200")
        expect(assigns(:users)).to eq(@contractor.users)
      end
    end

    context "User is SubContractor" do
      login_sub_contractor_owner(@sub_contractor)
      it "Should see all users of a contractor or sub_contractor" do
        get :index, sub_contractor_id: @sub_contractor
        expect(response.code).to eq("200")
        expect(assigns(:users)).to eq(@sub_contractor.users)
      end
    end
  end
end