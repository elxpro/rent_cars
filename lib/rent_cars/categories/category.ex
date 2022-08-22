defmodule RentCars.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset

  @fields ~w/name description/a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "categories" do
    field :name, :string
    field :description, :string

    timestamps()
  end

  def changeset(category, attrs) do
    category
    |> cast(attrs, @fields)
    |> unique_constraint(:name)
    |> validate_required(@fields)
    |> update_change(:name, &String.upcase/1)
  end

  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end
end
