defmodule RentCars.Sessions.ResetPasswordTest do
  use RentCars.DataCase

  alias RentCars.Sessions.ResetPassword
  alias RentCars.Shared.Tokenr
  import RentCars.AccountsFixtures

  test "reset user password" do
    user = user_fixture()
    token = Tokenr.generate_forgot_email_token(user)

    params = %{
      "token" => token,
      "user" => %{"password" => "adm@elxpro.coM1", "password_confirmation" => "adm@elxpro.coM1"}
    }

    assert {:ok, user_return} = ResetPassword.execute(params)
    assert user.email == user_return.email
  end

  test "throw error when token is invalid" do
    params = %{"token" => "dasfdsa", "user" => %{}}
    assert {:error, message} = ResetPassword.execute(params)
    assert "Invalid token" == message
  end
end
