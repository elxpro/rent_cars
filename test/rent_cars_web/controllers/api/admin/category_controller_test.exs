defmodule RentCarsWeb.Api.Admin.CategoryControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.CategoriesFixtures

  setup :include_admin_token

  test "list all categories", %{conn: conn} do
    conn = get(conn, Routes.api_admin_category_path(conn, :index))
    assert json_response(conn, 200)["data"] == []
  end

  test "create category when data is valid", %{conn: conn} do
    attrs = %{name: "Sport", description: "pumpkin 123"}
    conn = post(conn, Routes.api_admin_category_path(conn, :create, category: attrs))
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get(conn, Routes.api_admin_category_path(conn, :show, id))

    name = String.upcase(attrs.name)
    description = attrs.description

    assert %{
             "id" => ^id,
             "name" => ^name,
             "description" => ^description
           } = json_response(conn, 200)["data"]
  end

  test "try to create category when data is invalid", %{conn: conn} do
    attrs = %{description: "pumpkin 123"}
    conn = post(conn, Routes.api_admin_category_path(conn, :create, category: attrs))
    assert json_response(conn, 422)["errors"] == %{"name" => ["can't be blank"]}
  end

  describe "update category" do
    setup [:create_category]

    test "update category with valid data", %{conn: conn, category: category} do
      conn =
        put(conn, Routes.api_admin_category_path(conn, :update, category),
          category: %{name: "update category name"}
        )

      assert %{"id" => id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_admin_category_path(conn, :show, id))

      name = String.upcase("update category name")

      assert %{
               "id" => ^id,
               "name" => ^name
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete category" do
    setup [:create_category]

    test "delete category", %{conn: conn, category: category} do
      id = category.id
      conn = delete(conn, Routes.api_admin_category_path(conn, :delete, category))

      assert response(conn, 204)

      assert_error_sent 404, fn -> get(conn, Routes.api_admin_category_path(conn, :show, id)) end
    end
  end

  defp create_category(_) do
    category = category_fixture()
    %{category: category}
  end
end
