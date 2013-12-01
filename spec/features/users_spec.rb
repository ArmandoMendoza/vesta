require 'spec_helper'

describe "Users" do

  describe "User visit index" do
    before do
      @admin = User.make!(:contractor_admin)
      @contractor = Contractor.make!
      3.times { User.make!(:contractor_regular, company: @contractor) }
      login @admin
    end

    it "should have a table with all users of company" do
      visit contractor_users_path(@contractor)
      within('table') do
        @contractor.users.each do |user|
          expect(page).to have_content(user.first_name)
        end
      end
    end
  end

  describe "User visit show" do
    before do
      @admin = User.make!(:contractor_admin)
      @contractor = Contractor.make!
      3.times { User.make!(:contractor_regular, company: @contractor) }
      login @admin
    end
    it "should have show all information of user" do
      user = @contractor.users.first
      visit contractor_user_path(@contractor, user)
      expect(page).to have_content(user.full_name)
      expect(page).to have_content(user.first_name)
      expect(page).to have_content(user.last_name)
      expect(page).to have_content(user.phone)
      expect(page).to have_content(user.email)
    end
  end

  describe "User create a new user" do

    context "with valid values" do

      context "User is admin" do
        it "should show the info of new user" do
          admin = User.make!(:contractor_admin)
          contractor = Contractor.make!
          login admin
          visit new_contractor_user_path(contractor)
          expect(page).to have_selector('#user_user_type')
          within('form#new_user') do
            fill_in :user_first_name, with: "Armando"
            fill_in :user_last_name, with: "Mendoza"
            fill_in :user_phone, with: "276-3535340"
            fill_in :user_email, with: "coopnova@hotmail.com"
            fill_in :user_password, with: "superpass"
            fill_in :user_password_confirmation, with: "superpass"
            select "admin", from: :user_user_type
            click_button "Guardar"
          end
          expect(page).to have_content("Armando")
          expect(page).to have_content("Mendoza")
          expect(page).to have_content("admin")
          expect(page).to have_content("276-3535340")
          expect(page).to have_content("coopnova@hotmail.com")
        end
      end

      context "User is owner" do

        it "should show the info of new user" do
          owner = User.make!(:contractor_owner)
          contractor = owner.company
          login owner
          visit new_contractor_user_path(contractor)
          expect(page).to_not have_selector('#user_user_type')
          within('form#new_user') do
            fill_in :user_first_name, with: "Armando"
            fill_in :user_last_name, with: "Mendoza"
            fill_in :user_phone, with: "276-3535340"
            fill_in :user_email, with: "coopnova@hotmail.com"
            fill_in :user_password, with: "superpass"
            fill_in :user_password_confirmation, with: "superpass"
            click_button "Guardar"
          end
          expect(page).to have_content("Armando")
          expect(page).to have_content("Mendoza")
          expect(page).to have_content("regular")
          expect(page).to have_content("276-3535340")
          expect(page).to have_content("coopnova@hotmail.com")
        end
      end
    end

    context "with invalid values" do
      it "should show the errors on the form" do
        owner = User.make!(:contractor_owner)
        contractor = owner.company
        login owner
        visit new_contractor_user_path(contractor)
        within('form#new_user') do
          fill_in :user_first_name, with: "Armando"
          fill_in :user_last_name, with: "Mendoza"
          fill_in :user_phone, with: "276-3535340"
          fill_in :user_email, with: ""
          fill_in :user_password, with: "superpass"
          fill_in :user_password_confirmation, with: ""
          click_button "Guardar"
        end
        expect(page).to have_content(I18n.t("errors.messages.confirmation"))
        expect(page).to have_content(I18n.t("errors.messages.blank"))
      end
    end
  end

  describe "User edit a user" do
    it "should show the edited info of user" do
      contractor = Contractor.make!
      owner = User.make!(:contractor_owner, company: contractor)
      login owner
      visit edit_contractor_user_path(contractor, owner)
      within('form') do
        fill_in :user_first_name, with: "Lucia"
        click_button "Guardar"
      end
      expect(page).to have_content("Lucia")
    end
  end
end