defmodule UserDatabase.Repo.Migrations.AddUserTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :profile_id, references(:profiles), null: false
      add :locale_id, references(:locales), null: false
      timestamps()
    end

    create unique_index(:users, [:profile_id, :locale_id], name: :users_profile_locale_unique_index)
  end
end

