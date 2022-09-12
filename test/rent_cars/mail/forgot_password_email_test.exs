defmodule RentCars.Mail.ForgotPasswordEmailTest do
  use RentCars.DataCase
  import RentCars.AccountsFixtures
  alias RentCars.Mail.ForgotPasswordEmail

  test "send email to reset password" do
    user = user_fixture()
    token = "ljdafslkjadslkjflkjadf"
    email_expected = ForgotPasswordEmail.create_email(user, token)
    assert email_expected.to == [{"elxpro first_name", "elxpro@email"}]
  end
end
