defmodule RentCarsWeb.Api.SessionController do
  use RentCarsWeb, :controller
  alias RentCars.Sessions
  action_fallback RentCarsWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, user, token} <- Sessions.create(email, password) do
      session = %{user: user, token: token}

      conn
      |> put_status(:created)
      |> render("show.json", session: session)
    end
  end

  def me(conn, %{"token" => token}) do
    with {:ok, user} <- Sessions.me(token) do
      session = %{user: user, token: token}
      render(conn, "show.json", session: session)
    end
  end
end
