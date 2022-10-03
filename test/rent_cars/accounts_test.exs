defmodule RentCars.AccountsTest do
  use RentCars.DataCase
  alias RentCars.Accounts
  import RentCars.AccountsFixtures

  describe "upload avatar" do
    test "upload avatar image" do
      user = user_fixture()

      photo = %Plug.Upload{
        content_type: "image/png",
        filename: "avatar.png",
        path: "test/support/fixtures/avatar.png"
      }

      assert {:ok, user_updated} = Accounts.upload_photo(user.id, photo)
      assert user_updated.avatar.file_name == "avatar.png"
    end
  end

  describe "get_user" do
    test "get_user!/1" do
      user = user_fixture()

      assert Accounts.get_user!(user.id).email == user.email
    end
  end

  describe "create users" do
    test "throw an error when the fields are not unique" do
      valid_attrs = %{
        first_name: "elxpro first_name",
        last_name: "elxpro last_name",
        user_name: "elxpro user_name",
        password: "elxpro_password",
        password_confirmation: "elxpro_password",
        email: "Elxpro@email",
        drive_license: "elxpro drive_license"
      }

      Accounts.create_user(valid_attrs)

      assert {:error, changeset} = Accounts.create_user(valid_attrs)
      assert %{drive_license: ["has already been taken"]} == errors_on(changeset)
    end

    test "create_user/1 with valid datas" do
      valid_attrs = %{
        first_name: "elxpro first_name",
        last_name: "elxpro last_name",
        user_name: "elxpro user_name",
        password: "elxpro_password",
        password_confirmation: "elxpro_password",
        email: "Elxpro@email",
        drive_license: "elxpro drive_license"
      }

      assert {:ok, user} = Accounts.create_user(valid_attrs)

      assert user.first_name == valid_attrs.first_name
      assert user.last_name == valid_attrs.last_name
      assert user.user_name == valid_attrs.user_name
      assert user.email == String.downcase(valid_attrs.email)
      assert user.drive_license == valid_attrs.drive_license
    end

    test "throw an error when e-mail is invalid" do
      valid_attrs = %{
        first_name: "elxpro first_name",
        last_name: "elxpro last_name",
        user_name: "elxpro user_name",
        password: "elxpro password",
        password_confirmation: "elxpro password_confirmation",
        email: "elxpro email",
        drive_license: "elxpro drive_license"
      }

      assert {:error, changeset} = Accounts.create_user(valid_attrs)
      assert "type a valid e-mail" in errors_on(changeset).email
    end

    test "throw an error when password is invalid" do
      valid_attrs = %{
        first_name: "elxpro first_name",
        last_name: "elxpro last_name",
        user_name: "elxpro user_name",
        password: "elx",
        password_confirmation: "elxpro password_confirmation",
        email: "elxpro email",
        drive_license: "elxpro drive_license"
      }

      assert {:error, changeset} = Accounts.create_user(valid_attrs)
      assert "should be at least 6 character(s)" in errors_on(changeset).password
    end
  end
end
