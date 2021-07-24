defmodule GetRepositoriesWeb.FallbackController do
  use GetRepositoriesWeb, :controller

  alias GetRepositories.Error
  alias GetRepositoriesWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
