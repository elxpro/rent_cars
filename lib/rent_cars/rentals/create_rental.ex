defmodule RentCars.Rentals.CreateRental do
  import Ecto.Query
  import RentCars.Shared.DateValidations, only: [check_if_is_more_than_24_hours: 1]
  alias RentCars.Accounts.User
  alias RentCars.Cars.Car
  alias RentCars.Repo

  def execute(car_id, expected_return_date, user_id) do
    with true <- check_if_is_more_than_24_hours(expected_return_date),
         {:ok, car} <- car_available?(car_id),
         true <- user_booked_car?(user_id) do
      car
    else
      error -> error
    end
  end

  defp car_available?(car_id) do
    Car
    |> Repo.get(car_id)
    |> check_car_availability()
  end

  defp check_car_availability(%{available: false}), do: {:error, "Car is unavailable"}
  defp check_car_availability(car), do: {:ok, car}

  defp user_booked_car?(user_id) do
    err = {:error, "User has a reservation"}

    User
    |> join(:inner, [u], r in assoc(u, :rentals))
    |> where([u, _r], u.id == ^user_id)
    |> where([_u, r], is_nil(r.end_date))
    |> select([u, _r], count(u.id))
    |> Repo.one()
    |> then(&(&1 == 0 || err))
  end
end
