use Mix.Config

#########################
config :usertask, UsertaskWeb.Endpoint,
       secret_key_base: "T6eCj67rJD1ip9euz113rYcYLXVBk0MjotnvuEIN2Vxvi/y+7BHnhiDnZ+/NZJlJ"

# Configure your database
config :usertask, Usertask.Repo,
       adapter: Ecto.Adapters.Postgres,
       username: "zikun",
       password: "123456",
       database: "usertask_prod",
       pool_size: 15