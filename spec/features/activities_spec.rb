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
    it "should have show all information of project" do
      activity = Activity.make!(project: @project)
      visit project_activity_path(@project, activity)
      expect(page).to have_content(activity.name)
      expect(page).to have_content(activity.description)
      expect(page).to have_content(activity.init_date)
      expect(page).to have_content(activity.finish_date)
      expect(page).to have_content(activity.full_execution_time)
    end
  end

  describe "User create a new activity" do

    context "with valid values" do
      it "should show the info of new activity after create a activity" do
        visit new_project_activity_path(@project)
        within('form') do
          fill_in :activity_name, with: "Actividad de Pruebas"
          fill_in :activity_description, with: "Nada de importancia"
          select "1", from: :activity_init_date_3i
          select "enero", from: :activity_init_date_2i
          select "2013", from: :activity_init_date_1i
          fill_in :activity_execution_time, with: "10"
          fill_in :activity_unit_execution_time, with: Activity::UNIT[:days]
          click_button "Crear Actividad"
        end
        expect(page).to have_content("Actividad de Pruebas")
        expect(page).to have_content("Nada de importancia")
        expect(page).to have_content("2013-01-01")
        expect(page).to have_content("10 days")
        expect(page).to have_content("2013-01-11")
      end
    end

    context "with invalid values" do
      it "should show the errors on the form" do
        visit new_project_activity_path(@project)
        within('form') do
          fill_in :activity_name, with: ""
          fill_in :activity_description, with: "Nada de importancia"
          fill_in :activity_execution_time, with: ""
          fill_in :activity_unit_execution_time, with: Activity::UNIT[:days]
          click_button "Crear Actividad"
        end
        expect(page).to have_content(I18n.t("errors.messages.blank"))
      end
    end
  end

  describe "User edit activity" do
    it "should show the edited info of activity" do
      activity = Activity.make!(project: @project)
      visit edit_project_activity_path(@project, activity)
      within('form') do
        fill_in :activity_name, with: "Actividad Editada"
        click_button "Actualizar Actividad"
      end
      expect(page).to have_content("Actividad Editada")
    end
  end
end