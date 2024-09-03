defmodule UserDatabase.Repo.Migrations.AddLocaleToProfile do
  use Ecto.Migration

  def change do
    alter table(:profiles) do
      add :locale_id, references(:locales)
    end
  end
end
