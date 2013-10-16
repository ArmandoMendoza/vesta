require 'spec_helper'

describe "Collaborators" do
  before do
    @contractor_owner = User.make!(:contractor_owner)
    @project = Project.make!(contractor: @contractor_owner.company)
    login @contractor_owner
  end

  describe "User visit index" do
    before do
      user = User.make!(:contractor_regular, company: @contractor_owner.company)
      Collaborator.make!(:contractor_inspector, user: user, project: @project)
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
      company = @contractor_owner.company
      @user = User.make!(:contractor_regular, company: company)
      @other_user = User.make!(:contractor_regular, company: company)
    end

    context "with valid values" do
      it "should return to index after create a collaborator" do
        visit new_project_collaborator_path(@project)
        within('form#new_collaborator') do
          select @user.full_name, from: "collaborator_user_id"
          select "Inspector", from: "collaborator_collaborator_type"
          click_button "Crear Colaborador"
        end
        expect(page).to have_content(@user.full_name)
        expect(page).to have_content("Inspector")
      end
    end

    context "with invalid values" do
      it "should show the errors on the form" do
        visit new_project_collaborator_path(@project)
        within('form#new_collaborator') do
          select @user.full_name, from: "collaborator_user_id"
          select "Inspector", from: "collaborator_collaborator_type"
          click_button "Crear Colaborador"
        end
        visit new_project_collaborator_path(@project)
        within('form#new_collaborator') do
          select @other_user.full_name, from: "collaborator_user_id"
          select "Inspector", from: "collaborator_collaborator_type"
          click_button "Crear Colaborador"
        end
        expect(page).to have_content(I18n.t("errors.messages.taken"))
      end
    end
  end

  describe "User edit a collaborator" do
    it "should show the edited info of contractor" do
      user = User.make!(:contractor_regular, company: @contractor_owner.company)
      collaborator = Collaborator.make!(:contractor_inspector, user: user, project: @project)
      other_user = User.make!(:contractor_regular, company: @contractor_owner.company)
      visit edit_project_collaborator_path(@project, collaborator)
      within('form') do
        select other_user.full_name, from: "collaborator_user_id"
        click_button "Actualizar Colaborador"
      end
      expect(page).to have_content(other_user.full_name)
    end
  end
end