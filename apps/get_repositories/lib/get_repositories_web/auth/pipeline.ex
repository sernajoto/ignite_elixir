defmodule GetRepositoriesWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :get_repositories

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
