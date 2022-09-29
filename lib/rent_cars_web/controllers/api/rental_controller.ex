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
end
