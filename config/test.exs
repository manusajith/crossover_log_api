use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :log_api, LogApiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :ex_unit,
  capture_log: true

# Configure the event store database
config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "log_api_eventstore_test",
  hostname: "localhost",
  pool_size: 1

# Configure the read store database
config :log_api, LogApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "log_api_readstore_test",
  hostname: "localhost",
  pool_size: 1

config :comeonin, :bcrypt_log_rounds, 4
