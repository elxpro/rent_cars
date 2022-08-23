defmodule RentCars.AccountsTest do
  use RentCars.DataCase
  alias RentCars.Accounts

  describe "create users" do
    test "create_user/1 with valid datas" do
      valid_attrs = %{
        first_name: "elxpro first_name",
        last_name: "elxpro last_name",
        user_name: "elxpro user_name",
        password: "elxpro password",
        password_confirmation: "elxpro password_confirmation",
        email: "elxpro email",
        drive_license: "elxpro drive_license"
      }

      assert {:ok, user} = Accounts.create_user(valid_attrs)

      assert user.first_name == valid_attrs.first_name
      assert user.last_name == valid_attrs.last_name
      assert user.user_name == valid_attrs.user_name
      assert user.email == valid_attrs.email
      assert user.drive_license == valid_attrs.drive_license
    end
  end
end
