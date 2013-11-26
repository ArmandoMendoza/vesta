require 'spec_helper'

describe User do

  it { should belong_to(:company) }
  it { should have_many(:collaborators) }
  it { should have_many(:followers) }
  it { should have_many(:projects).through(:collaborators) }
  it { should have_many(:activities).through(:followers) }


  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }


  def user_params
    {first_name: "Armando", last_name: "Mendoza", password: "12345678", email: "fcoarmando@hotmail.com",
     company: Contractor.make!}
  end

  describe "Callback#set_user_type" do
    it "if user_type is blank it set User::USER_TYPE[:regular] by default" do
      user = User.create!(user_params)
      expect(user.user_type).to eq(User::USER_TYPE[:regular])
    end
  end
end
