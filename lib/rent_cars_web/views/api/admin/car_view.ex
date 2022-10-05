defmodule RentCarsWeb.Api.Admin.CarView do
  use RentCarsWeb, :view
  alias RentCars.Cars.CarPhoto
  alias RentCarsWeb.Api.Admin.SpecificationView

  def render("show.json", %{car: car}) do
    %{data: render_one(car, __MODULE__, "car.json")}
  end

  def render("car.json", %{car: car}) do
    %{
      id: car.id,
      description: car.description,
      brand: car.brand,
      available: car.available,
      daily_rate: car.daily_rate,
      license_plate: car.license_plate,
      fine_amount: Money.to_string(car.fine_amount),
      category_id: car.category_id,
      specifications: load_specifications(car.specifications),
      images: load_images(car),
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

  defp load_images(%{images: images} = cars) do
    if Ecto.assoc_loaded?(cars.images) do
      Enum.map(images, &CarPhoto.url({&1.image, &1}, signed: true))
    else
      []
    end
  end
end
