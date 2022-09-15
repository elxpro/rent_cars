defmodule RentCarsWeb.Api.Admin.CarView do
  use RentCarsWeb, :view
  alias RentCarsWeb.Api.Admin.SpecificationView

  def render("show.json", %{car: car}) do
    %{data: render_one(car, __MODULE__, "car.json")}
  end

  def render("car.json", %{car: car}) do
    %{
      id: car.id,
      description: car.description,
      brand: car.brand,
      daily_rate: car.daily_rate,
      license_plate: car.license_plate,
      fine_amount: car.fine_amount,
      category_id: car.category_id,
      specifications: load_specifications(car.specifications),
      name: car.name
    }
  end

  defp load_specifications(specifications) do
    if Ecto.assoc_loaded?(specifications) do
      SpecificationView.render("index.json", %{specifications: specifications})
    else
      nil
    end
  end
end
