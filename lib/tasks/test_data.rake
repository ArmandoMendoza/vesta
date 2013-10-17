namespace :test_data do

  desc "create a basic data to test interfaces"
  task :basic_bundle => :environment do
    require 'machinist'
    require Rails.root.join("spec/support/blueprints")
    2.times do |x|
      ####Contractors
      contractor = Contractor.make!
      contractor_owner = User.make!(:contractor_owner, company: contractor,
        email: "owner_contractor_#{x + 1}@vesta.co.ve")
      ####Contractors
      sub_contractor = SubContractor.make!
      sub_contractor_owner = User.make!(:sub_contractor_owner, company: sub_contractor,
        email: "owner_sub_contractor_#{x + 1}@vesta.co.ve")
      ####Users
      3.times do |u|
        User.make!(:sub_contractor_regular, company: sub_contractor)
        User.make!(:contractor_regular, company: contractor)
      end
      ####Projects
      Project.make!(contractor: contractor, sub_contractor: sub_contractor )
    end
    ##### Project without SubContractor to assign later. Only for test.
    2.times { Project.make!(contractor: Contractor.last, sub_contractor: nil) }
  end
end