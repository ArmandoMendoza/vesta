require 'spec_helper'

describe "Activities" do
  before do
    @admin = User.make!(:contractor_admin)
    @project = Project.make!(contractor: @admin.company)
    login @admin
  end

  describe "User visit index" do
    before do
      3.times { Activity.make!(project: @project) }
    end

    it "should have a table with all activities of projects" do
      visit project_activities_path(@project)
      within('table') do
        @project.activities.load.each do |activities|
          expect(page).to have_content(activities.name)
        end
      end
    end
  end

  describe "User visit show" do
    before do
      @activity = Activity.make!(project: @project)
      visit project_activity_path(@project, @activity)
    end

    it "should have show all information of project" do
      expect(page).to have_content(@activity.name)
      expect(page).to have_content(@activity.description)
      expect(page).to have_content(@activity.init_date.strftime('%d-%m-%Y'))
      expect(page).to have_content(@activity.finish_date.strftime('%d-%m-%Y'))
      expect(page).to have_content(@activity.full_execution_time)
      expect(page).to have_content("#{@activity.current_execution.percent}%")
    end

    it "should have a link to show a form to create an execution to activity", js: true do
      click_link "Actualizar"
      expect(page).to have_content("Actualizar Ejecucion")
      expect(page).to have_select("execution_percent")
      select "50", from: "execution_percent"
      click_button "Actualizar"
      expect(page).to have_content("50%")
    end
  end

  describe "User create a new activity" do

    context "with valid values" do
      it "should show the info of new activity after create a activity" do
        visit new_project_activity_path(@project)
        within('form') do
          fill_in :activity_name, with: "Actividad de Pruebas"
          fill_in :activity_description, with: "Nada de importancia"
          fill_in :activity_init_date, with: "01-01-2013"
          fill_in :activity_execution_time, with: "10"
          select "Dias", from: :activity_unit_execution_time
          click_button "Guardar"
        end
        expect(page).to have_content("Actividad de Pruebas")
        expect(page).to have_content("Nada de importancia")
        expect(page).to have_content("01-01-2013")
        expect(page).to have_content("10 Dias")
        expect(page).to have_content("11-01-2013")
      end

      it "should assign the current user as owner of activity" do
        visit new_project_activity_path(@project)
        within('form') do
          fill_in :activity_name, with: "Actividad de Pruebas"
          fill_in :activity_description, with: "Nada de importancia"
          fill_in :activity_init_date, with: "01-01-2013"
          fill_in :activity_execution_time, with: "10"
          select "Dias", from: :activity_unit_execution_time
          click_button "Guardar"
        end
        activity = Activity.last
        expect(activity.role_of(@admin)).to eq("owner")
      end
    end

    context "with invalid values" do
      it "should show the errors on the form" do
        visit new_project_activity_path(@project)
        within('form') do
          fill_in :activity_name, with: ""
          fill_in :activity_description, with: "Nada de importancia"
          fill_in :activity_execution_time, with: "AA"
          select "Dias", from: :activity_unit_execution_time
          click_button "Guardar"
        end
        expect(page).to have_content(I18n.t("errors.messages.blank"))
        expect(page).to have_content(I18n.t("errors.messages.not_a_number"))
      end
    end
  end

  describe "User edit activity" do
    it "should show the edited info of activity" do
      activity = Activity.make!(project: @project)
      visit edit_project_activity_path(@project, activity)
      within('form') do
        fill_in :activity_name, with: "Actividad Editada"
        click_button "Guardar"
      end
      expect(page).to have_content("Actividad Editada")
    end
  end
end