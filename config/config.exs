# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :melp_intellimetrica,
  ecto_repos: [MelpIntellimetrica.Repo]

# Configures the endpoint
config :melp_intellimetrica, MelpIntellimetricaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2ogjP2HC5kAwkgm4tB7EB2wtVKyi1JYi0TZIuywCgPM+MVLV3xKAqKvmk/VnQreU",
  render_errors: [view: MelpIntellimetricaWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MelpIntellimetrica.PubSub,
  live_view: [signing_salt: "sWSlcAw8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
