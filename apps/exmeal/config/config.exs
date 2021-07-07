# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :exmeal,
  ecto_repos: [Exmeal.Repo]

config :exmeal, Exmeal.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :exmeal, ExmealWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HjPBvQBeSYkoQ4bB+rUW0aKhbEJ0zBn/f71sk4DzQWs42LlwFPs1yN8T8qQqYvcx",
  render_errors: [view: ExmealWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Exmeal.PubSub,
  live_view: [signing_salt: "lXY5kHUA"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
