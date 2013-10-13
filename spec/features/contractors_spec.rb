require 'spec_helper'

describe "Contractors" do
  describe "User visit index" do
    before do
      3.times { Contractor.make! }
    end

    it "should have a table with all contractors" do
      login User.make!(:contractor_admin)
      visit contractors_path
      within('table') do
        Contractor.all.each do |contractor|
          expect(page).to have_content(contractor.name)
        end
      end
    end
  end

  describe "User visit show" do
    it "should have show all information of contractor" do
      contractor = Contractor.make!
      login User.make!(:contractor_admin)
      visit contractor_path(contractor)
      expect(page).to have_content("Contratante #{contractor.name}")
      expect(page).to have_content(contractor.rif)
      expect(page).to have_content(contractor.address)
      expect(page).to have_content(contractor.phone)
      expect(page).to have_content(contractor.email)
    end
  end
end