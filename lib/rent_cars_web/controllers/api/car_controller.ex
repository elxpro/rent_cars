defmodule RentCarsWeb.Api.CarController do
  use RentCarsWeb, :controller
  alias RentCars.Cars
  action_fallback RentCarsWeb.FallbackController

  def index(conn, params) do
    cars =
      params
      |> convert_to_atom_key()
      |> Cars.list_cars()

    render(conn, "index.json", %{cars: cars})
  end

  defp convert_to_atom_key(params) do
    params |> Enum.map(fn {type, filter} -> {String.to_atom(type), filter} end)
  end
end
