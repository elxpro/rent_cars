defmodule RentCars.Mail.ForgotPasswordEmailTest do
  use RentCars.DataCase
  import RentCars.AccountsFixtures
  import Swoosh.TestAssertions
  alias RentCars.Mail.ForgotPasswordEmail

  test "send email to reset password" do
    user = user_fixture()
    token = "ljdafslkjadslkjflkjadf"
    email_expected = ForgotPasswordEmail.create_email(user, token)
    assert email_expected.to == [{"elxpro first_name", "elxpro@email"}]
    assert_email_not_sent(email_expected)
  end

  test "sent email to reset password" do
    user = user_fixture()
    token = "ljdafslkjadslkjflkjadf"
    ForgotPasswordEmail.send_forgot_password_email(user, token)
    assert {:email, email_result} = assert_email_sent()
    assert [{user.first_name, user.email}] == email_result.to
  end
end
