defmodule RentCarsWeb.Api.RentalView do
  use RentCarsWeb, :view
  alias RentCarsWeb.Api.Admin.CarView

  def render("index.json", %{rentals: rentals}) do
    %{data: render_many(rentals, __MODULE__, "rental.json")}
  end

  def render("show.json", %{rental: rental}) do
    %{data: render_one(rental, __MODULE__, "rental.json")}
  end

  def render("rental.json", %{rental: rental}) do
    %{
      id: rental.id,
      car: load_car(rental.car, rental.car_id),
      end_date: rental.end_date,
      expected_return_date: rental.expected_return_date,
      start_date: rental.start_date,
      total: rental.total,
      user_id: rental.user_id
    }
  end

  defp load_car(car, car_id) do
    if Ecto.assoc_loaded?(car) do
      CarView.render("show.json", %{car: car})
    else
      %{id: car_id}
    end
  end
end
