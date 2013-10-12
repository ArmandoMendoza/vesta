require 'spec_helper'

describe "Dashboard" do

  describe "User visit index" do
    it "should have a welcome message" do
      visit dashboard_path
      expect(page).to have_content("Bienvenido a Dashboard")
    end
  end
end