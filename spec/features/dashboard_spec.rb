require 'spec_helper'

describe "Dashboard" do

  describe "User visit index" do

    context "without login" do
      it "should have be redirect to login page" do
        visit dashboard_path
        expect(page).to have_content("Sign in")
      end
    end

    context "with login" do

      it "should have a welcome message" do
        login User.make!(:contractor_admin)
        visit dashboard_path
        expect(page).to have_content("Bienvenido a Dashboard")
      end
    end
  end
end