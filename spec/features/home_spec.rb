require 'spec_helper'

describe "Home" do

  describe "User visit index" do
    it "should have a message with version of vesta" do
      visit root_path
      expect(page).to have_content("Vesta v2")
    end
  end
end