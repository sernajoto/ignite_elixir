defmodule GetRepositories.Github.Client do
  use Tesla

  alias GetRepositories.Error
  alias Tesla.Env

  @base_url "https://api.github.com/users/"

  plug Tesla.Middleware.Headers, [{"user-agent", "request"}]
  plug Tesla.Middleware.JSON

  def get_user_repositories(url \\ @base_url, username) do
    "#{url}#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, format_response(body)}
  end

  defp handle_get({:ok, %Env{status: 404, body: _body}}) do
    {:error, Error.build(:not_found, "User not found!")}
  end

  defp handle_get({:ok, %Env{status: status, body: _body}}) do
    {:error, Error.build(status, "There was a problem!")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end

  defp format_response(body), do: Enum.map(body, &get_repositorie_info/1)

  defp get_repositorie_info(repo) do
    %{
      id: repo["id"],
      name: repo["name"],
      description: repo["description"],
      html_url: repo["html_url"],
      stargazers_count: repo["stargazers_count"]
    }
  end
end
