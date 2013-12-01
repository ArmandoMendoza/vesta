require 'spec_helper'

describe "SubContractors" do
  before do
    login User.make!(:sub_contractor_admin)
  end

  describe "User visit index" do
    before do
      3.times { SubContractor.make! }
    end

    it "should have a table with all sub_contractors" do
      visit sub_contractors_path
      within('table') do
        SubContractor.all.each do |sub_contractor|
          expect(page).to have_content(sub_contractor.name)
        end
      end
    end
  end

  describe "User visit show" do
    it "should have show all information of sub_contractor" do
      sub_contractor = SubContractor.make!
      visit sub_contractor_path(sub_contractor)
      expect(page).to have_content("Contratista #{sub_contractor.name}")
      expect(page).to have_content(sub_contractor.rif)
      expect(page).to have_content(sub_contractor.address)
      expect(page).to have_content(sub_contractor.phone)
      expect(page).to have_content(sub_contractor.email)
    end
  end

  describe "User create a new sub_contractor" do
    context "with valid values" do
      it "should show the info of new sub_contractor" do
        visit new_sub_contractor_path
        within('form#new_sub_contractor') do
          fill_in :sub_contractor_name, with: "Cooperativa Nova"
          fill_in :sub_contractor_rif, with: "J-31446097-8"
          fill_in :sub_contractor_address, with: "San Cristobal"
          fill_in :sub_contractor_phone, with: "276-3535340"
          fill_in :sub_contractor_email, with: "coopnova@hotmail.com"
          click_button "Guardar"
        end
        expect(page).to have_content("Contratista Cooperativa Nova")
        expect(page).to have_content("J-31446097-8")
        expect(page).to have_content("San Cristobal")
        expect(page).to have_content("276-3535340")
        expect(page).to have_content("coopnova@hotmail.com")
      end
    end

    context "with invalid values" do
      it "should show the errors on the form" do
        visit new_sub_contractor_path
        within('form#new_sub_contractor') do
          fill_in :sub_contractor_name, with: ""
          fill_in :sub_contractor_rif, with: "J31446097-8"
          fill_in :sub_contractor_address, with: ""
          fill_in :sub_contractor_phone, with: "02763535340"
          fill_in :sub_contractor_email, with: ""
          click_button "Guardar"
        end
        expect(page).to have_content(I18n.t("errors.messages.invalid"))
        expect(page).to have_content(I18n.t("errors.messages.blank"))
      end
    end
  end

  describe "User edit a sub_contractor" do
    it "should show the edited info of sub_contractor" do
      sub_contractor = SubContractor.make!
      visit edit_sub_contractor_path(sub_contractor)
      within('form') do
        fill_in :sub_contractor_name, with: "Cooperativa Nova"
        click_button "Guardar"
      end
      expect(page).to have_content("Contratista Cooperativa Nova")
    end
  end
end