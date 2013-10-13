tampaco = Contractor.create!(name: "Tampaco S.A", rif: "J-31446097-8",
  address: "Barrio Obrero", email: "tampaco@gmail.com", phone: "276-3535340")
admin = User.create!(first_name: "Administrador", last_name: "Tampaco",
  email: "admin@vesta.co.ve", password: "12345678", company: tampaco)