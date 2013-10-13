require 'spec_helper'

describe User do

  it { should belong_to(:company) }
  it { should have_many(:collaborators) }
  it { should have_many(:projects).through(:collaborators) }

  describe "Callback#set_user_type" do
    it "if user_type is blank it set User::USER_TYPE[:regular] by default" do
      user = User.create!(first_name: "Armando", last_name: "Mendoza", password: "12345678",
        company: Contractor.make!, email: "fcoarmando@hotmail.com")
      expect(user.user_type).to eq(User::USER_TYPE[:regular])
    end
  end
end
