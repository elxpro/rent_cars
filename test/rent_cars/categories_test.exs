defmodule RentCars.CategoriesTest do
  use RentCars.DataCase
  alias RentCars.Categories
  alias RentCars.Categories.Category

  test "list_categories/0 returns all categories" do
    assert Categories.list_categories() == []
  end

  test "create_category/1 with valid data" do
    attrs = %{description: "pumpkin 123", name: "sport"}
    assert {:ok, %Category{} = category} = Categories.create_category(attrs)
    assert category.name == String.upcase(attrs.name)
    assert category.description == attrs.description
  end

  test "create_category/1 with duplicated name" do
    attrs = %{description: "pumpkin 123", name: "sport"}
    Categories.create_category(attrs)

    assert {:error, changeset} = Categories.create_category(attrs)
    assert "has already been taken" in errors_on(changeset).name
  end

  test "create_category/1 with without description" do
    attrs = %{name: "sport"}

    assert {:error, changeset} = Categories.create_category(attrs)
    assert "can't be blank" in errors_on(changeset).description
    assert %{description: ["can't be blank"]} = errors_on(changeset)
  end

  test "get_category/1" do
    attrs = %{description: "pumpkin 123", name: "sport"}
    {:ok, category} = Categories.create_category(attrs)

    assert Categories.get_category(category.id) == category
  end

  test "update_category/2" do
    attrs = %{description: "pumpkin 123", name: "sport"}
    {:ok, category} = Categories.create_category(attrs)

    {:ok, category_updated} = Categories.update_category(category, %{name: "Suv"})
    assert category_updated.name == "SUV"
  end

  test "delete_category/1" do
    attrs = %{description: "pumpkin 123", name: "sport"}
    {:ok, category} = Categories.create_category(attrs)

    {:ok, %Category{}} = Categories.delete_category(category)
    assert Categories.get_category(category.id) == nil
  end
end
