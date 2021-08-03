defmodule GetRepositoriesWeb.RepositoriesView do
  use GetRepositoriesWeb, :view

  def render("user_repositories.json", %{
        user_repositories: user_repositories,
        new_token: new_token
      }) do
    %{
      data: user_repositories,
      message: "Successfully obtained user repositories!",
      new_token: new_token
    }
  end
end
