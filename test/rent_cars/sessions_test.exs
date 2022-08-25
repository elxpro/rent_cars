defmodule RentCars.SessionsTest do
  use RentCars.DataCase

  alias RentCars.Sessions
  import RentCars.AccountsFixtures

  test "get user from token" do
    user = user_fixture()
    password = "elxpro_password"

    assert {:ok, _user_return, token} = Sessions.create(user.email, password)

    assert {:ok, user_return} = Sessions.me(token)

    assert user.email == user_return.email
  end

  test "return authenticated user" do
    user = user_fixture()
    password = "elxpro_password"

    assert {:ok, user_return, _token} = Sessions.create(user.email, password)
    assert user.email == user_return.email
  end

  test "throw error when password is incorrect" do
    user = user_fixture()
    password = "12323"
    assert {:error, message} = Sessions.create(user.email, password)
    assert "Email or password is incorrect" == message
  end

  test "throw error when email is invalid" do
    email = "sfdasf@fsdfdsf"
    password = "12323"
    assert {:error, message} = Sessions.create(email, password)
    assert "Email or password is incorrect" == message
  end
end
