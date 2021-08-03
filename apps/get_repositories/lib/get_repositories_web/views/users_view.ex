defmodule GetRepositoriesWeb.UsersView do
  use GetRepositoriesWeb, :view

  alias GetRepositories.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User created!",
      user: user
    }
  end

  def render("login.json", %{token: token}), do: %{token: token}

  def render("user.json", %{new_token: new_token, user: %User{} = user}) do
    %{user: user, new_token: new_token}
  end
end
