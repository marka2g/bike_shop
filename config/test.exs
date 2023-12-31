import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :bcrypt_elixir, :log_rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :bike_shop, BikeShop.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "bike_shop_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bike_shop, BikeShopWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "35dQ8mjUakx/20CCdrvDXtUDJdgvZ2Am4v/NCIzMT0xEi/oTClWHFAoDIqrpJ4to",
  server: false

# config :bike_shop, :public_uploads_path, "/uploads/test"
config :bike_shop, :uploads_dir, "priv/static/uploads/test/"

# In test we don't send emails.
config :bike_shop, BikeShop.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
