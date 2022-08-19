defmodule RentCarsWeb.Api.CategoryControllerTest do
  use RentCarsWeb.ConnCase

  test "list all categories", %{conn: conn} do
    conn = get(conn, "/api/categories")

    assert json_response(conn, 200)["data"] == [
             %{
               "description" => "pumpkin 123",
               "id" => "123123",
               "name" => "SPOT"
             }
           ]
  end
end
