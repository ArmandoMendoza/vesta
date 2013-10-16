require 'spec_helper'

describe "Projects" do

  describe "User visit index" do
    before do
      @admin = User.make!(:contractor_admin)
      3.times { Project.make! }
      login @admin
    end

    it "should have a table with projects" do
      visit projects_path
      within('table') do
        Project.all.each do |project|
          expect(page).to have_content(project.name)
        end
      end
    end
  end

  describe "User visit show" do
    before do
      @admin = User.make!(:contractor_admin)
      @project = Project.make!
      login @admin
    end
    it "should have show all information of project" do
      visit project_path(@project)
      expect(page).to have_content(@project.name)
      expect(page).to have_content(@project.budget)
      expect(page).to have_content(@project.init_date)
      expect(page).to have_content(@project.finish_date)
      expect(page).to have_content(@project.address)
    end
  end

  describe "User create a new Project" do
    before do
      @contractor = Contractor.make!
      @admin = User.make!(:contractor_admin)
      login @admin
    end

    context "with valid values" do
      it "should show the info of new project after create a project" do
        visit new_project_path
        within('form#new_project') do
          fill_in :project_name, with: "Proyecto de Pruebas"
          fill_in :project_contract_number, with: "PJ1234"
          fill_in :project_budget, with: "1000000"
          fill_in :project_advance, with: "0"
          fill_in :project_address, with: "Av Ppl de Pueblo Nuevo"
          fill_in :project_address_city, with: "San Cristobal"
          fill_in :project_address_municipality, with: "San Cristobal"
          fill_in :project_address_state, with: "Tachira"
          fill_in :project_latitude, with: "0"
          fill_in :project_longitude, with: "0"
          select @contractor.name, from: :project_contractor_id
          select "1", from: :project_init_date_3i
          select "enero", from: :project_init_date_2i
          select "2013", from: :project_init_date_1i
          select "1", from: :project_finish_date_3i
          select "enero", from: :project_finish_date_2i
          select "2014", from: :project_finish_date_1i
          click_button "Crear Proyecto"
        end
        expect(page).to have_content("Proyecto de Pruebas")
        expect(page).to have_content("1000000.0")
        expect(page).to have_content("Av Ppl de Pueblo Nuevo")
        expect(page).to have_content("2013-01-01")
        expect(page).to have_content("2013-01-01")
      end
    end

    context "with invalid values" do
      it "should show the errors on the form" do
        visit new_project_path
        within('form#new_project') do
          fill_in :project_name, with: ""
          fill_in :project_contract_number, with: ""
          fill_in :project_budget, with: "aavbba"
          fill_in :project_advance, with: "0"
          fill_in :project_address, with: ""
          fill_in :project_address_city, with: "San Cristobal"
          fill_in :project_address_municipality, with: "San Cristobal"
          fill_in :project_address_state, with: "Tachira"
          fill_in :project_latitude, with: "0"
          fill_in :project_longitude, with: "0"
          select @contractor.name, from: :project_contractor_id
          select "1", from: :project_init_date_3i
          select "enero", from: :project_init_date_2i
          select "2013", from: :project_init_date_1i
          select "1", from: :project_finish_date_3i
          select "enero", from: :project_finish_date_2i
          select "2014", from: :project_finish_date_1i
          click_button "Crear Proyecto"
        end
        expect(page).to have_content(I18n.t("errors.messages.blank"))
        expect(page).to have_content(I18n.t("errors.messages.not_a_number"))
      end
    end
  end

  describe "User edit a Project" do
    it "should show the edited info of project" do
      project = Project.make!
      admin = User.make!(:contractor_admin)
      login admin
      visit edit_project_path(project)
      within('form') do
        fill_in :project_name, with: "Proyecto Editado"
        click_button "Actualizar Proyecto"
      end
      expect(page).to have_content("Proyecto Editado")
    end
  end
end