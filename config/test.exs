use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :djbit, DjBitWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :djbit, DjBit.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "djbit_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
