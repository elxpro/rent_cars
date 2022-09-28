defmodule RentCarsWeb.Api.CarView do
  use RentCarsWeb, :view
  alias RentCarsWeb.Api.Admin.CarView, as: CarAdminView

  def render("index.json", %{cars: cars}) do
    %{data: render_many(cars, CarAdminView, "car.json")}
  end
end
