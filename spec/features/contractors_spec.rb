require 'spec_helper'

describe "Contractors" do
  before do
    login User.make!(:contractor_admin)
  end

  describe "User visit index" do
    before do
      3.times { Contractor.make! }
    end

    it "should have a table with all contractors" do
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
      visit contractor_path(contractor)
      expect(page).to have_content("Contratante #{contractor.name}")
      expect(page).to have_content(contractor.rif)
      expect(page).to have_content(contractor.address)
      expect(page).to have_content(contractor.phone)
      expect(page).to have_content(contractor.email)
    end
  end

  describe "User create a new contractor" do
    context "with valid values" do
      it "should show the info of new contractor" do
        visit new_contractor_path
        within('form#new_contractor') do
          fill_in :contractor_name, with: "Cooperativa Nova"
          fill_in :contractor_rif, with: "J-31446097-8"
          fill_in :contractor_address, with: "San Cristobal"
          fill_in :contractor_phone, with: "276-3535340"
          fill_in :contractor_email, with: "coopnova@hotmail.com"
          click_button "Crear Contractor"
        end
        expect(page).to have_content("Contratante Cooperativa Nova")
        expect(page).to have_content("J-31446097-8")
        expect(page).to have_content("San Cristobal")
        expect(page).to have_content("276-3535340")
        expect(page).to have_content("coopnova@hotmail.com")
      end
    end

    context "with invalid values" do
      it "should show the errors on the form" do
        visit new_contractor_path
        within('form#new_contractor') do
          fill_in :contractor_name, with: ""
          fill_in :contractor_rif, with: "J31446097-8"
          fill_in :contractor_address, with: ""
          fill_in :contractor_phone, with: "02763535340"
          fill_in :contractor_email, with: ""
          click_button "Crear Contractor"
        end
        expect(page).to have_content(I18n.t("errors.messages.invalid"))
        expect(page).to have_content(I18n.t("errors.messages.blank"))
      end
    end
  end

  describe "User edit a contractor", js: true do
    it "should show the edited info of contractor" do
      contractor = Contractor.make!
      visit edit_contractor_path(contractor)
      within('form') do
        fill_in :contractor_name, with: "Cooperativa Nova"
        click_button "Actualizar Contractor"
      end
      expect(page).to have_content("Contratante Cooperativa Nova")
    end
  end
end