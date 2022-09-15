defmodule RentCarsWeb.Api.Admin.CarController do
  use RentCarsWeb, :controller
  alias RentCars.Cars
  action_fallback RentCarsWeb.FallbackController

  def create(conn, %{"car" => car}) do
    with {:ok, car} <- Cars.create(car) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_admin_car_path(conn, :show, car))
      |> render("show.json", car: car)
    end
  end

  def update(conn, %{"id" => id, "car" => car_params}) do
    with {:ok, car} <- Cars.update(id, car_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_admin_car_path(conn, :show, car))
      |> render("show.json", car: car)
    end
  end

  def show(conn, %{"id" => id}) do
    car = Cars.get_car!(id)
    render(conn, "show.json", car: car)
  end
end
