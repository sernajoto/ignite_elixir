defmodule RockliveryWeb.FallbackController do
  use RockliveryWeb, :controller

  alias Rocklivery.Error
  alias RockliveryWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
