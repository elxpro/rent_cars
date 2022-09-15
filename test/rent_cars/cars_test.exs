defmodule RentCars.CarsTest do
  use RentCars.DataCase
  alias RentCars.Cars
  import RentCars.CategoriesFixtures
  import RentCars.CarsFixtures

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

  test "update a car with success" do
    car = car_fixture()
    payload = %{name: "Lancer 2023"}
    assert {:ok, car} = Cars.update(car.id, payload)
    assert car.name == payload.name
  end

  test "throw error when try updating the licence_plate" do
    car = car_fixture()
    payload = %{license_plate: "update license_plate"}
    assert {:error, changeset} = Cars.update(car.id, payload)
    assert "you can`t update license_plate" in errors_on(changeset).license_plate
  end
end
