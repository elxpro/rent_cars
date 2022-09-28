defmodule RentCars.Rentals.CreateRentalTest do
  use RentCars.DataCase
  alias RentCars.Rentals.CreateRental
  import RentCars.CarsFixtures

  describe "create rentals" do
    test "throw error when car is not available" do
      car = car_fixture(%{available: false})
      assert {:error, "Car is unavailable"} == CreateRental.execute(car.id)
    end
  end
end
