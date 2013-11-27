require 'spec_helper'

describe "Collaborators" do
  before do
    @sub_contractor_owner = User.make!(:sub_contractor_owner)
    @project = Project.make!(sub_contractor: @sub_contractor_owner.company)
  end

  describe "User visit index" do
    before do
      user = User.make!(:sub_contractor_regular, company: @sub_contractor_owner.company)
      Collaborator.make!(:sub_contractor_residente, user: user, project: @project)
      login @sub_contractor_owner
    end

    it "should have a table with all collaborators" do
      visit project_collaborators_path(@project)
      within('table') do
        @project.collaborators.each do |collaborator|
          expect(page).to have_content(collaborator.user.full_name)
          expect(page).to have_content(collaborator.collaborator_type)
        end
      end
    end
  end

  describe "User create a new collaborator" do
    before do
      company = @sub_contractor_owner.company
      @user = User.make!(:sub_contractor_regular, company: company)
      @other_user = User.make!(:sub_contractor_regular, company: company)
      login @sub_contractor_owner
    end

    context "with valid values" do
      it "should return to index after create a collaborator" do
        visit new_project_collaborator_path(@project)
        within('form#new_collaborator') do
          select @user.full_name, from: "collaborator_user_id"
          select "Residente", from: "collaborator_collaborator_type"
          click_button "Crear Colaborador"
        end
        expect(page).to have_content(@user.full_name)
        expect(page).to have_content("Residente")
      end
    end

    context "with invalid values" do
      it "should show the errors on the form" do
        visit new_project_collaborator_path(@project)
        within('form#new_collaborator') do
          select @user.full_name, from: "collaborator_user_id"
          select "Residente", from: "collaborator_collaborator_type"
          click_button "Crear Colaborador"
        end
        visit new_project_collaborator_path(@project)
        within('form#new_collaborator') do
          select "", from: "collaborator_user_id"
          select "Residente", from: "collaborator_collaborator_type"
          click_button "Crear Colaborador"
        end
        expect(page).to have_content(I18n.t("errors.messages.blank"))
      end
    end
  end

  describe "User edit a collaborator" do
    it "should show the edited info of contractor" do
      login @sub_contractor_owner
      user = User.make!(:sub_contractor_regular, company: @sub_contractor_owner.company)
      other_user = User.make!(:sub_contractor_regular, company: @sub_contractor_owner.company)
      collaborator = Collaborator.make!(:sub_contractor_residente, user: user, project: @project)
      visit edit_project_collaborator_path(@project, collaborator)
      within('form') do
        select other_user.full_name, from: "collaborator_user_id"
        click_button "Actualizar Colaborador"
      end
      expect(page).to have_content(other_user.full_name)
    end
  end
end