defmodule RentCarsWeb.Api.UserView do
  use RentCarsWeb, :view
  alias RentCars.Accounts.Avatar

  def render("show.json", %{user: user}) do
    %{data: render_one(user, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      user_name: user.user_name,
      drive_license: user.drive_license,
      email: user.email,
      role: user.role,
      avatar: Avatar.url({user.avatar, user}, signed: true)
    }
  end
end
