defmodule RentCarsWeb.Api.CarControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.CarsFixtures

  describe "list cars" do
    test "list all available cars", %{conn: conn} do
      car_fixture()
      car_fixture(%{brand: "Pumpkin"})

      conn = get(conn, Routes.api_car_path(conn, :index, %{brand: "pump"}))
      car_returned = json_response(conn, 200)["data"] |> hd
      assert "Pumpkin" == car_returned["brand"]
    end
  end
end
