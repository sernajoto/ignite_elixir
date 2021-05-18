defmodule Rocklivery.Repo do
  use Ecto.Repo,
    otp_app: :rocklivery,
    adapter: Ecto.Adapters.Postgres
end
