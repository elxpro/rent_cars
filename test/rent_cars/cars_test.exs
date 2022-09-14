defmodule RentCars.CarsTest do
  use RentCars.DataCase
  alias RentCars.Cars
  import RentCars.CategoriesFixtures

  test "create a car with success" do
    category = category_fixture()

    payload = %{
      name: "Lancer",
      description: "good car",
      brand: "Mitsubishi",
      daily_rate: 100,
      license_plate: "adfdf 1033",
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

    assert {:ok, car} = Cars.create(payload)

    assert car.name == payload.name
    assert car.description == payload.description
    assert car.brand == payload.brand
    assert car.daily_rate == payload.daily_rate
    assert car.license_plate == String.upcase(payload.license_plate)
    assert car.fine_amount == payload.fine_amount

    Enum.each(car.specifications, fn specification ->
      assert specification.name in Enum.map(payload.specifications, & &1.name)
      assert specification.description in Enum.map(payload.specifications, & &1.description)
    end)
  end
end
