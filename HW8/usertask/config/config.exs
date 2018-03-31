# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :usertask,
  ecto_repos: [Usertask.Repo]

# Configures the endpoint
config :usertask, UsertaskWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "T6eCj67rJD1ip9euz113rYcYLXVBk0MjotnvuEIN2Vxvi/y+7BHnhiDnZ+/NZJlJ",
  render_errors: [view: UsertaskWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Usertask.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
