defmodule RentCars.Cars do
  import Ecto.Query
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

  def list_cars(filter_params \\ []) do
    query = where(Car, [c], c.available == true)
    # TODO load car_images

    filter_params
    |> Enum.reduce(query, fn
      {:name, name}, query ->
        name = "%" <> name <> "%"
        where(query, [c], ilike(c.name, ^name))
    end)
    |> preload([:specifications])
    |> Repo.all()
  end
end
