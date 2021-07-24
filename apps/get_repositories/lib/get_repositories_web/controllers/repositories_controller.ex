defmodule GetRepositoriesWeb.RepositoriesController do
  use GetRepositoriesWeb, :controller

  alias GetRepositoriesWeb.FallbackController

  action_fallback FallbackController

  def get_user_repositories(conn, %{"username" => username}) do
    with {:ok, user_repositories} <- GetRepositories.get_user_repositories(username) do
      conn
      |> put_status(:ok)
      |> render("user_repositories.json", user_repositories: user_repositories)
    end
  end
end
