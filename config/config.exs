import Config

config :user_database, UserDatabase.Repo,
  database: "user_database_repo",
  username: "postgres",
  password: "gustav7393",
  hostname: "localhost"

config :user_database,
      ecto_repos: [UserDatabase.Repo]
