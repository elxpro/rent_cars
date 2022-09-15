defmodule RentCars.Cars do
  alias __MODULE__.Car
  alias RentCars.Repo

  def create(attrs) do
    %Car{}
    |> Car.changeset(attrs)
    |> Repo.insert()
  end
end
