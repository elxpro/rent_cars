alias RentCars.Accounts

%{
  first_name: "elxpro first_name",
  last_name: "elxpro last_name",
  user_name: "user",
  password: "user@elxpro.coM1",
  password_confirmation: "user@elxpro.coM1",
  email: "user@elxpro.com",
  drive_license: "123123",
  role: "USER"
}
|> Accounts.create_user()

%{
  first_name: "elxpro first_name",
  last_name: "elxpro last_name",
  user_name: "admin",
  password: "admin@elxpro.coM1",
  password_confirmation: "admin@elxpro.coM1",
  email: "admin@elxpro.com",
  drive_license: "ssdfsdfdsf",
  role: "ADMIN"
}
|> Accounts.create_user()
