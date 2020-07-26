# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :hack_news_backend,
  ecto_repos: [HackNewsBackend.Repo]

# Configures the endpoint
config :hack_news_backend, HackNewsBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "v4aswMNN7qC88wXNfB5oplVTWF5RwivHNGBaivi95mAv/c7t1zdiywmORKY83OHj",
  render_errors: [view: HackNewsBackendWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HackNewsBackend.PubSub,
  live_view: [signing_salt: "Ydg/3IFd"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :hack_news_backend, HackNewsBackend.Auth.Authenticaton,
  issuer: "hack_news_backend",
  secret_key: "mt2XuuZtlPWr6QrIzMx8n0yGOOhxYvbkytIfxWNx/vNMdgjx06PTZRrALnVfjsC5"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
