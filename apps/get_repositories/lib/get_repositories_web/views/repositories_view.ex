defmodule GetRepositoriesWeb.RepositoriesView do
  use GetRepositoriesWeb, :view

  def render("user_repositories.json", %{user_repositories: user_repositories}) do
    %{
      data: user_repositories,
      message: "Successfully obtained user repositories!"
    }
  end
end
