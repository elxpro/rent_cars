defmodule RentCarsWeb.Api.AccountView do
  use RentCarsWeb, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, __MODULE__, "account.json")}
  end

  def render("show.json", %{account: user}) do
    %{data: render_one(user, __MODULE__, "account.json")}
  end

  def render("account.json", %{account: user}) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      user_name: user.user_name,
      drive_license: user.drive_license,
      email: user.email,
      role: user.role
    }
  end
end
