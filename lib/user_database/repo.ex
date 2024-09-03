defmodule UserDatabase.Repo do
  use Ecto.Repo,
    otp_app: :user_database,
    adapter: Ecto.Adapters.Postgres
end
