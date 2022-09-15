defmodule RentCars.CarsFixtures do
  alias RentCars.Cars
  import RentCars.CategoriesFixtures

  def car_attrs(attrs \\ %{}) do
    category = category_fixture()

    valid_attrs = %{
      name: "Lancer",
      description: "good car",
      brand: "Mitsubishi",
      daily_rate: 100,
      license_plate: "adfdf #{:rand.uniform(10_000)}",
      fine_amount: 30,
      category_id: category.id,
      specifications: [
        %{
          name: "wheels",
          description: "pumpkin"
        },
        %{
          name: "pumpkin wheels",
          description: "1323"
        }
      ]
    }

    Enum.into(attrs, valid_attrs)
  end

  def car_fixture(attrs \\ %{}) do
    {:ok, car} =
      attrs
      |> car_attrs()
      |> Cars.create()

    car
  end
end
