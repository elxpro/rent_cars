defmodule RentCars.Shared.DateValidations do
  def check_if_is_more_than_24_hours(date) do
    now = NaiveDateTime.utc_now()
    err = {:error, "Invalid return date"}

    date
    |> NaiveDateTime.from_iso8601!()
    |> Timex.diff(now, :days)
    |> then(&(&1 > 0 || err))
  end
end
