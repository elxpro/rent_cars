defmodule RentCarsWeb.Api.UserController do
  use RentCarsWeb, :controller
  alias RentCars.Accounts
  action_fallback RentCarsWeb.FallbackController

  def create(conn, %{"user" => account}) do
    with {:ok, user} <- Accounts.create_user(account) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def upload_photo(conn, %{"avatar" => params}) do
    [user_id] = get_req_header(conn, "user_id")

    with {:ok, user} <- Accounts.upload_photo(user_id, params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end
