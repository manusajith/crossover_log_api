use Mix.Config

# General application configuration
config :log_api,
  ecto_repos: [LogApi.Repo]

# Configures the endpoint
config :log_api, LogApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hXslnxxJrzfI918PrmgkZZwJU3GYhT8y1500AP6Foxq9aDgjChbi0BcMdsscFkAs",
  render_errors: [view: LogApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: LogApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections,
  repo: LogApi.Repo

config :vex,
  sources: [
    LogApi.Accounts.Validators,
    LogApi.Log.Validators,
    LogApi.Validation.Validators,
    Vex.Validators
  ]

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer:        "LogApi",
  ttl:           {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key:    "IOjbrty1eMEBzc5aczQn0FR4Gd8P9IF1cC7tqwB7ThV/uKjS5mrResG1Y0lCzTNJ",
  serializer:    LogApi.Auth.GuardianSerializer

import_config "#{Mix.env}.exs"
