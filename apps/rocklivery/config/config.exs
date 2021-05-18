# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rocklivery,
  ecto_repos: [Rocklivery.Repo]

config :rocklivery, Rocklivery.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :rocklivery, RockliveryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+4jEXImzR2euE/2plUle01DJlvvE2ObiZDKejAwHaSv3iYKfC1u3Cq6XfeWwkcnQ",
  render_errors: [view: RockliveryWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Rocklivery.PubSub,
  live_view: [signing_salt: "u6hLwyQf"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
