defmodule GetRepositories.Repo do
  use Ecto.Repo,
    otp_app: :get_repositories,
    adapter: Ecto.Adapters.Postgres
end
