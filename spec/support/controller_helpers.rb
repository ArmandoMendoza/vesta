module ControllerHelpers
  def login_admin
    before(:each) do
      @admin = User.make!(:contractor_admin)
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in @admin
    end
  end

  def login_contractor_owner(contractor)
    before(:each) do
      @contractor_owner = User.make!(:contractor_owner, company: contractor)
      @request.env["devise.mapping"] = Devise.mappings[:contractor_owner]
      sign_in @contractor_owner
    end
  end

  def login_sub_contractor_owner(sub_contractor)
    before(:each) do
      @sub_contractor_owner = User.make!(:sub_contractor_owner, company: sub_contractor)
      @request.env["devise.mapping"] = Devise.mappings[:sub_contractor_owner]
      sign_in @sub_contractor_owner
    end
  end
end