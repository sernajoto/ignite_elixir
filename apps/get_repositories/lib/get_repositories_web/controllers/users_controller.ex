defmodule GetRepositoriesWeb.UsersController do
  use GetRepositoriesWeb, :controller

  alias GetRepositories.User
  alias GetRepositoriesWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- GetRepositories.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- GetRepositories.get_user_by_id(id),
         {:ok, new_token} <- Guardian.refresh_token(conn) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user, new_token: new_token)
    end
  end

  def login(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("login.json", token: token)
    end
  end
end
