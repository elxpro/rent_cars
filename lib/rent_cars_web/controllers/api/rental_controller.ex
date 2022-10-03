defmodule RentCarsWeb.Api.RentalController do
  use RentCarsWeb, :controller
  action_fallback RentCarsWeb.FallbackController
  alias RentCars.Rentals

  def create(conn, params) do
    [user_id] = get_req_header(conn, "user_id")
    params = Map.put(params, "user_id", user_id)

    with {:ok, %{rental: rental}} <- Rentals.create(params) do
      conn |> put_status(:created) |> render("show.json", rental: rental)
    end
  end

  def return(conn, %{"id" => id}) do
    [user_id] = get_req_header(conn, "user_id")

    with %{rental: {:ok, %{return_car: rental}}} <- Rentals.return_car(id, user_id) do
      conn |> put_status(:created) |> render("show.json", rental: rental)
    end
  end

  def index(conn, _params) do
    [user_id] = get_req_header(conn, "user_id")
    rentals = Rentals.list_rentals(user_id)
    render(conn, "index.json", rentals: rentals)
  end
end
