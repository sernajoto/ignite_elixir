defmodule GetRepositories do
  alias GetRepositories.Github.Client, as: RepositoriesClient
  alias GetRepositories.Users.Create, as: UserCreate
  alias GetRepositories.Users.Get, as: UserGet

  defdelegate get_user_repositories(username), to: RepositoriesClient, as: :get_user_repositories

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
end
