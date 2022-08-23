defmodule RentCarsWeb.Api.AccountControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.AccountsFixtures

  test "create user when data is valid", %{conn: conn} do
    attrs = user_attrs()
    conn = post(conn, Routes.api_account_path(conn, :create, user: attrs))
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get(conn, Routes.api_account_path(conn, :show, id))

    email = String.downcase(attrs.email)

    assert %{
             "id" => ^id,
             "email" => ^email
           } = json_response(conn, 200)["data"]
  end
end
