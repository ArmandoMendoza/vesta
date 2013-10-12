require 'machinist/active_record'

Contractor.blueprint do
  name { Faker::Name.name }
  address { "#{Faker::Address.street_address}, #{Faker::Address.city}"}
  rif { "J-12345678-#{sn}"}
  phone { Faker::PhoneNumber.phone_number }
  email { Faker::Internet.email }
end

SubContractor.blueprint do
  name { Faker::Name.name }
  address { "#{Faker::Address.street_address}, #{Faker::Address.city}"}
  rif { "J-98765432-#{sn}"}
  phone { Faker::PhoneNumber.phone_number }
  email { Faker::Internet.email }
end

User.blueprint(:contractor) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  phone { Faker::PhoneNumber.phone_number }
  email { Faker::Internet.email }
  password { "secret12" }
  company { Contractor.make! }
end

User.blueprint(:sub_contractor) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  phone { Faker::PhoneNumber.phone_number }
  email { Faker::Internet.email }
  password { "secret12" }
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
end