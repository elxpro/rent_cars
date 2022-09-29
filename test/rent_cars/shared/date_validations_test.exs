defmodule RentCars.Shared.DateValidationsTest do
  use RentCars.DataCase
  alias RentCars.Shared.DateValidations

  test "throw error if data is less than 24 hours" do
    end_date =
      NaiveDateTime.utc_now()
      |> then(&%{&1 | hour: &1.hour + 5})
      |> NaiveDateTime.to_string()

    expected = {:error, "Invalid return date"}
    result = DateValidations.check_if_is_more_than_24_hours(end_date)

    assert expected == result
  end

  test "return true when is more than 24 hours" do
    end_date =
      NaiveDateTime.utc_now()
      |> then(&%{&1 | month: &1.month + 1})
      |> NaiveDateTime.to_string()

    assert DateValidations.check_if_is_more_than_24_hours(end_date)
  end
end
