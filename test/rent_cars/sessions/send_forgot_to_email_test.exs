defmodule RentCars.Sessions.SendForgotToEmailTest do
  use RentCars.DataCase

  alias RentCars.Sessions.SendForgotToEmail
  import RentCars.AccountsFixtures

  test "send email to reset password" do
    user = user_fixture()
    assert {:ok, user_return, _token} = SendForgotToEmail.execute(user.email)
    assert user.email == user_return.email
  end

  test "throw error when user does not exist" do
    assert {:error, message} = SendForgotToEmail.execute("asdfsadfafd")
    assert "User does not exist" == message
  end
end
