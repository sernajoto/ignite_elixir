# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :get_repositories,
  ecto_repos: [GetRepositories.Repo]

config :get_repositories, GetRepositories.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :get_repositories, GetRepositoriesWeb.Auth.Guardian,
  issuer: "get_repositories",
  secret_key: "RHis9NmmDkthAEyYKQc0vcWnqHpMX3hZGFqYLqwhLvlR9Gk1uQw2Qk+O/39Z30MK"

config :get_repositories, GetRepositoriesWeb.Auth.Pipeline,
  module: GetRepositoriesWeb.Auth.Guardian,
  error_handler: GetRepositoriesWeb.Auth.ErrorHandler

# Configures the endpoint
config :get_repositories, GetRepositoriesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/gapzGgMjLnGRq/mxlpIQyyljSXRHTahsAtoTl2yRGpaLMn5LrP4ULqUUy+qTv7H",
  render_errors: [view: GetRepositoriesWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GetRepositories.PubSub,
  live_view: [signing_salt: "a0Xzc1sV"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
