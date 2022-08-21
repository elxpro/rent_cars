defmodule RentCarsWeb.Api.FallbackController do
  use RentCarsWeb, :controller
  alias RentCarsWeb.ChangesetView

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ChangesetView)
    |> render("error.json", changeset: changeset)
  end
end
