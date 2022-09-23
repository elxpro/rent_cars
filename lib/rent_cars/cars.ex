defmodule RentCars.Cars do
  alias __MODULE__.Car
  alias RentCars.Repo

  def get_car!(id), do: Repo.get!(Car, id) |> Repo.preload(:specifications)

  def create(attrs) do
    %Car{}
    |> Car.changeset(attrs)
    |> Repo.insert()
  end

  def update(car_id, attrs) do
    car_id
    |> get_car!()
    |> Car.update_changeset(attrs)
    |> Repo.update()
  end
end
