defmodule RockliveryWeb.WelcomeController do
  use RockliveryWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("Welcome!")
  end
end
