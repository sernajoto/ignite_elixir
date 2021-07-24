defmodule GetRepositories do
  alias GetRepositories.Github.Client, as: RepositoriesClient

  defdelegate get_user_repositories(username), to: RepositoriesClient, as: :get_user_repositories
end
