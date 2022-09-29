defmodule RentCars.Rentals.Rental do
  use Ecto.Schema
  import Ecto.Changeset
  alias RentCars.Accounts.User
  alias RentCars.Cars.Car

  @fields [:end_date, :total]
  @required [:start_date, :expected_return_date, :car_id, :user_id]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "rentals" do
    field :end_date, :naive_datetime
    field :expected_return_date, :naive_datetime
    field :start_date, :naive_datetime
    field :total, :integer
    belongs_to :car, Car
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(rental, attrs) do
    rental
    |> cast(attrs, @fields ++ @required)
    |> validate_required(@required)
  end
end
