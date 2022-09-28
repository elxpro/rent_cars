defmodule RentCars.CategoriesFixtures do
  alias RentCars.Categories

  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        description: "some category description",
        name: "some category name #{:rand.uniform(10_000)}"
      })
      |> Categories.create_category()

    category
  end
end
