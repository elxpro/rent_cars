defmodule RentCars.Rentals.ReturnCarTest do
  use RentCars.DataCase
  import RentCars.CarsFixtures
  import RentCars.AccountsFixtures
  import RentCars.RentalsFixtures
  alias RentCars.Rentals.ReturnCar

  describe "return car" do
    setup do
      car = car_fixture(%{available: false})
      user = user_fixture()
      %{car: car, user: user}
    end

    test "thow error when reservation does not exist" do
      assert {:error, "Car reservation does not exit"} ==
               ReturnCar.execute(Ecto.UUID.generate(), Ecto.UUID.generate())
    end

    test "should not return negative or zero days", %{
      car: car,
      user: user
    } do
      today = Date.utc_today()
      expected_return_date = today |> Timex.shift(days: +5) |> Timex.to_naive_datetime()
      start_date = today |> Timex.to_naive_datetime()

      rental =
        rental_fixture(%{
          car_id: car.id,
          user_id: user.id,
          expected_return_date: expected_return_date,
          start_date: start_date
        })

      assert %{days: 1, delay: -4} = ReturnCar.execute(rental.id, user.id)
    end

    test "calculate total fees", %{
      car: car,
      user: user
    } do
      today = Date.utc_today()
      expected_return_date = today |> Timex.shift(days: +5) |> Timex.to_naive_datetime()
      start_date = today |> Timex.to_naive_datetime()

      rental =
        rental_fixture(%{
          car_id: car.id,
          user_id: user.id,
          expected_return_date: expected_return_date,
          start_date: start_date
        })

      assert %{total_fees: 100} = ReturnCar.execute(rental.id, user.id)
    end

    test "calculate total fees for three days", %{
      car: car,
      user: user
    } do
      today = Date.utc_today()
      expected_return_date = today |> Timex.shift(days: +5) |> Timex.to_naive_datetime()
      start_date = today |> Timex.shift(days: -3) |> Timex.to_naive_datetime()

      rental =
        rental_fixture(%{
          car_id: car.id,
          user_id: user.id,
          expected_return_date: expected_return_date,
          start_date: start_date
        })

      assert %{total_fees: 300} = ReturnCar.execute(rental.id, user.id)
    end

    test "calculate total fees with fine amount", %{
      car: car,
      user: user
    } do
      today = Date.utc_today()
      expected_return_date = today |> Timex.shift(days: -3) |> Timex.to_naive_datetime()
      start_date = today |> Timex.shift(days: -6) |> Timex.to_naive_datetime()

      rental =
        rental_fixture(%{
          car_id: car.id,
          user_id: user.id,
          expected_return_date: expected_return_date,
          start_date: start_date
        })

      assert %{total_fees: 690} = ReturnCar.execute(rental.id, user.id)
    end

    test "return the car", %{
      car: car,
      user: user
    } do
      today = Date.utc_today()
      expected_return_date = today |> Timex.shift(days: -3) |> Timex.to_naive_datetime()
      start_date = today |> Timex.shift(days: -6) |> Timex.to_naive_datetime()

      rental =
        rental_fixture(%{
          car_id: car.id,
          user_id: user.id,
          expected_return_date: expected_return_date,
          start_date: start_date
        })

      refute car.available

      assert %{rental: {:ok, %{car_is_available: car_result, return_car: rental}}} =
               ReturnCar.execute(rental.id, user.id)

      assert car_result.available
      assert rental.total == Money.new(690 * 100)
      assert not is_nil(rental.end_date)
    end

    test "calculate return date and delay", %{
      car: car,
      user: user
    } do
      today = Date.utc_today()
      expected_return_date = today |> Timex.shift(days: -5) |> Timex.to_naive_datetime()
      start_date = today |> Timex.shift(days: -7) |> Timex.to_naive_datetime()

      rental =
        rental_fixture(%{
          car_id: car.id,
          user_id: user.id,
          expected_return_date: expected_return_date,
          start_date: start_date
        })

      assert %{days: 7, delay: 5} = ReturnCar.execute(rental.id, user.id)
    end
  end
end
