defmodule HackNewsBackendWeb.Router do
  use HackNewsBackendWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug HackNewsBackend.Auth.AuthPipeline
  end
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HackNewsBackendWeb do
    pipe_through :browser
  end

  scope "/api", HackNewsBackendWeb, as: :api do
    pipe_through :api

    post "/user/sign_up", RegistrationController, :sign_up
    post "/user/sign_in", SessionController, :sign_in

    pipe_through :authenticated
    post "/challenge/team", TeamController, :create
    post "/challenge/team/user", TeamController, :add_user_to_team
    post "/challenge", ChallengeController, :create
    get "/challenge/:id", ChallengeController, :show
    get "/challenges", ChallengeController, :index
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
      pipe_through :browser
      live_dashboard "/dashboard", metrics: HackNewsBackendWeb.Telemetry
    end
  end
end
