import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :qr_elixir, QrElixirWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "N4XBM6JVOUvy9ASODKsZifxXRb7l3zpn8Gve6xvendAHfCoZpPSzC44hqpvlNMgY",
  server: false

# In test we don't send emails.
config :qr_elixir, QrElixir.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
