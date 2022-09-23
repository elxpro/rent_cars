defmodule RentCarsWeb.Api.Admin.CarControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.CarsFixtures
  import RentCars.CategoriesFixtures

  describe "cars create/update" do
    setup :include_admin_token

    test "create car when datas are valid", %{conn: conn} do
      category = category_fixture()

      payload = %{
        "name" => "Lancer",
        "description" => "good car",
        "brand" => "Mitsubishi",
        "daily_rate" => 100,
        "license_plate" => "adfdf #{:rand.uniform(10_000)}",
        "fine_amount" => 30,
        "category_id" => category.id
      }

      conn = post(conn, Routes.api_admin_car_path(conn, :create, car: payload))
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_admin_car_path(conn, :show, id))

      name = payload["name"]

      assert %{
               "id" => ^id,
               "name" => ^name
             } = json_response(conn, 200)["data"]
    end

    test "update car", %{conn: conn} do
      car = car_fixture()
      payload = %{"name" => "Lancer 123"}

      conn = put(conn, Routes.api_admin_car_path(conn, :update, car), car: payload)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_admin_car_path(conn, :show, id))

      name = payload["name"]

      assert %{
               "id" => ^id,
               "name" => ^name
             } = json_response(conn, 200)["data"]
    end
  end
end
