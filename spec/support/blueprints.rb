require 'machinist/active_record'

Contractor.blueprint do
  name { Faker::Name.name }
  address { "#{Faker::Address.street_address}, #{Faker::Address.city}"}
  rif { "J-123456#{sn}-1"}
  phone { "276-3535340" }
  email { Faker::Internet.email }
end

SubContractor.blueprint do
  name { Faker::Name.name }
  address { "#{Faker::Address.street_address}, #{Faker::Address.city}"}
  rif { "J-123456#{sn}-1"}
  phone { "276-3535340" }
  email { Faker::Internet.email }
end

# Users of Contractor
User.blueprint(:contractor_admin) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  phone { "276-3535340" }
  email { Faker::Internet.email }
  password { "secret12" }
  user_type { User::USER_TYPE[:admin] }
  company { Contractor.make! }
end

User.blueprint(:contractor_owner) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  phone { "276-3535340" }
  email { Faker::Internet.email }
  password { "secret12" }
  user_type { User::USER_TYPE[:owner] }
  company { Contractor.make! }
end

User.blueprint(:contractor_regular) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  phone { "276-3535340" }
  email { Faker::Internet.email }
  password { "secret12" }
  user_type { User::USER_TYPE[:regular] }
  company { Contractor.make! }
end

# Users of SubContractor
User.blueprint(:sub_contractor_admin) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  phone { "276-3535340" }
  email { Faker::Internet.email }
  password { "secret12" }
  user_type { User::USER_TYPE[:admin] }
  company { SubContractor.make! }
end

User.blueprint(:sub_contractor_owner) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  phone { "276-3535340" }
  email { Faker::Internet.email }
  password { "secret12" }
  user_type { User::USER_TYPE[:owner] }
  company { SubContractor.make! }
end

User.blueprint(:sub_contractor_regular) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  phone { "276-3535340" }
  email { Faker::Internet.email }
  password { "secret12" }
  user_type { User::USER_TYPE[:regular] }
  company { SubContractor.make! }
end

Project.blueprint do
  name { "Project Nro-#{sn}" }
  init_date { Date.today - 365 }
  finish_date { Date.today + 365 }
  budget { 5000000 }
  advance { 1000000 }
  contract_number { "112233-#{sn}" }
  contractor { Contractor.make! }
  sub_contractor { SubContractor.make! }
  address { Faker::Address.street_address }
  address_city { "San Cristobal"}
  address_municipality { "San Cristobal" }
  address_state { "Tachira" }
  latitude { 0 }
  longitude { 0 }
end

Collaborator.blueprint(:contractor_inspector) do
  user { User.make!(:contractor_regular) }
  project { Project.make! }
  collaborator_type { "Inspector" }
end

Collaborator.blueprint(:sub_contractor_inspector) do
  user { User.make!(:sub_contractor_regular) }
  project { Project.make! }
  collaborator_type { "Residente" }
end