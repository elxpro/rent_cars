defmodule RentCarsWeb.Api.Admin.CategoryController do
  use RentCarsWeb, :controller
  alias RentCars.Categories
  action_fallback RentCarsWeb.FallbackController

  def index(conn, _params) do
    categories = Categories.list_categories()
    render(conn, "index.json", categories: categories)
  end

  def create(conn, %{"category" => category}) do
    with {:ok, category} <- Categories.create_category(category) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_admin_category_path(conn, :show, category))
      |> render("show.json", category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Categories.get_category!(id)
    render(conn, "show.json", category: category)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Categories.get_category!(id)

    with {:ok, category} <- Categories.update_category(category, category_params) do
      render(conn, "show.json", category: category)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Categories.get_category!(id)

    with {:ok, _category} <- Categories.delete_category(category) do
      send_resp(conn, :no_content, "")
    end
  end
end
