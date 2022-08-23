defmodule RentCarsWeb.Api.AccountController do
  use RentCarsWeb, :controller
  alias RentCars.Accounts
  action_fallback RentCarsWeb.FallbackController

  def create(conn, %{"user" => account}) do
    with {:ok, user} <- Accounts.create_user(account) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_account_path(conn, :show, user))
      |> render("show.json", account: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", account: user)
  end
end
