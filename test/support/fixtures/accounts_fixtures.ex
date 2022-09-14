defmodule RentCars.AccountsFixtures do
  alias RentCars.Accounts

  def user_attrs(attrs \\ %{}) do
    valid_attrs = %{
      first_name: "elxpro first_name",
      last_name: "elxpro last_name",
      user_name: "elxpro user_name#{:rand.uniform(10_000)}",
      password: "elxpro_password",
      password_confirmation: "elxpro_password",
      email: "Elxpro@email#{:rand.uniform(10_000)}",
      drive_license: "elxpro drive_license #{:rand.uniform(10_000)}"
    }

    Enum.into(attrs, valid_attrs)
  end

  def admin_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> user_attrs()
      |> Map.put(:role, "ADMIN")
      |> Accounts.create_user()

    user
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> user_attrs()
      |> Accounts.create_user()

    user
  end
end
