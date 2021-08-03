defmodule GetRepositoriesWeb.Router do
  use GetRepositoriesWeb, :router

  alias GetRepositoriesWeb.Plugs.UUIDChecker

  pipeline :api do
    plug :accepts, ["json"]
    plug UUIDChecker
  end

  pipeline :auth do
    plug GetRepositoriesWeb.Auth.Pipeline
  end

  scope "/api", GetRepositoriesWeb do
    pipe_through [:api, :auth]

    get "/users/:username/repositories", RepositoriesController, :get_user_repositories

    get "/users/:id", UsersController, :show
  end

  scope "/api", GetRepositoriesWeb do
    pipe_through :api

    post "/users/", UsersController, :create
    post "/users/login", UsersController, :login
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: GetRepositoriesWeb.Telemetry
    end
  end
end
