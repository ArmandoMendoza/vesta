require 'spec_helper'

describe UsersController, type: :controller do

  def params
    { first_name: "Armando", last_name: "Mendoza", email: "fcoarmando@hotmail.com",
      password: "12345678", password_confirmation: "12345678", user_type: "Owner" }
  end

  before do
    @contractor = Contractor.make!
    @other_contractor = Contractor.make!
    @sub_contractor = SubContractor.make!
    @other_sub_contractor = SubContractor.make!
  end

  #### CONTRACTOR ####
  describe "Contractor Owner" do
    before do
      @contractor_owner = User.make!(:contractor_owner, company: @contractor)
      login @contractor_owner
    end

    describe "Read" do
      before do
        3.times do
          User.make!(:contractor_regular, company: @contractor)
          User.make!(:contractor_regular, company: @other_contractor)
        end
      end
      it "can see all users of his company from index" do
        get :index, contractor_id: @contractor.id
        expect(response.code).to eq("200")
        expect(assigns(:users)).to eq(@contractor.users.load.to_a)
      end
      it "can see info of user of his company from show" do
        get :show, id: @contractor.users.last, contractor_id: @contractor.id
        expect(response.code).to eq("200")
        expect(assigns(:user)).to eq(@contractor.users.last)
      end

      it "can see all users of other company from index" do
        get :index, contractor_id: @other_contractor.id
        expect(response.code).to eq("200")
        expect(assigns(:users)).to eq(@other_contractor.users.load.to_a)
      end
      it "can see info of user other company from show" do
        get :show, id: @other_contractor.users.last, contractor_id: @other_contractor.id
        expect(response.code).to eq("200")
        expect(assigns(:user)).to eq(@other_contractor.users.last)
      end
    end

    describe "Create" do
      it "can create a user of his company from new" do
        get :new, contractor_id: @contractor.id
        expect(response.code).to eq("200")
      end
      it "can create a user of his company from post" do
        post :create, user: params, contractor_id: @contractor.id
        expect(response.code).to eq("302")
      end

      it "cannot create a user to other company from new" do
        expect{
          get :new, contractor_id: @other_contractor.id
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot create a user to other company from post" do
        expect{
          post :create, user: params, contractor_id: @other_contractor.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Update" do
      before do
        @contractor_user = User.make!(:contractor_regular, company: @contractor)
        @other_contractor_user = User.make!(:contractor_regular, company: @other_contractor)
      end
      it "cannot update user of other company from edit" do
        expect{
          get :edit, contractor_id: @other_contractor.id, id: @other_contractor_user
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot update user of other company from update" do
        expect{
          patch :update, contractor_id: @other_contractor.id, user: params, id: @other_contractor_user
        }.to raise_error(CanCan::AccessDenied)
      end

      it "can update the user of his contractor from edit" do
        get :edit, contractor_id: @contractor.id, id: @contractor_user
        expect(response.code).to eq("200")
        expect(assigns(:user)).to eq(@contractor_user)
      end
      it "can update the user of his contractor from update" do
        patch :update, contractor_id: @contractor.id, user: params, id: @contractor_user
        expect(response.code).to eq("302")
        expect(assigns(:user)).to eq(@contractor_user)
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
        3.times do
          User.make!(:sub_contractor_regular, company: @sub_contractor)
          User.make!(:sub_contractor_regular, company: @other_sub_contractor)
        end
      end
      it "can see all users of his company from index" do
        get :index, sub_contractor_id: @sub_contractor.id
        expect(response.code).to eq("200")
        expect(assigns(:users)).to eq(@sub_contractor.users.load.to_a)
      end
      it "can see info of user of his company from show" do
        get :show, id: @sub_contractor.users.last, sub_contractor_id: @sub_contractor.id
        expect(response.code).to eq("200")
        expect(assigns(:user)).to eq(@sub_contractor.users.last)
      end
      it "can't see the users's list of other company" do
        expect{
          get :index, sub_contractor_id: @other_sub_contractor.id
        }.to raise_error(CanCan::AccessDenied)
      end
      it "can't see the user's info of other company" do
        expect{
          get :show, id: @other_sub_contractor.users.last, sub_contractor_id: @other_sub_contractor.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Create" do
      it "can create a user of his company from new" do
        get :new, sub_contractor_id: @sub_contractor.id
        expect(response.code).to eq("200")
      end
      it "can create a user of his company from post" do
        post :create, user: params, sub_contractor_id: @sub_contractor.id
        expect(response.code).to eq("302")
      end

      it "cannot create a user to other company from new" do
        expect{
          get :new, sub_contractor_id: @other_sub_contractor.id
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot create a user to other company from post" do
        expect{
          post :create, user: params, sub_contractor_id: @other_sub_contractor.id
        }.to raise_error(CanCan::AccessDenied)
      end
    end

    describe "Update" do
      before do
        @sub_contractor_user = User.make!(:sub_contractor_regular, company: @sub_contractor)
        @other_sub_contractor_user = User.make!(:sub_contractor_regular, company: @other_sub_contractor)
      end
      it "cannot update user of other company from edit" do
        expect{
          get :edit, sub_contractor_id: @other_sub_contractor.id, id: @other_sub_contractor_user
        }.to raise_error(CanCan::AccessDenied)
      end
      it "cannot update user of other company from update" do
        expect{
          patch :update, sub_contractor_id: @other_sub_contractor.id, user: params, id: @other_sub_contractor_user
        }.to raise_error(CanCan::AccessDenied)
      end

      it "can update users of his company from edit" do
        get :edit, sub_contractor_id: @sub_contractor.id, id: @sub_contractor_user
        expect(response.code).to eq("200")
        expect(assigns(:user)).to eq(@sub_contractor_user)
      end
      it "can update users of his company from update" do
        patch :update, sub_contractor_id: @sub_contractor.id, user: params, id: @sub_contractor_user
        expect(response.code).to eq("302")
        expect(assigns(:user)).to eq(@sub_contractor_user)
      end
    end
  end
end
