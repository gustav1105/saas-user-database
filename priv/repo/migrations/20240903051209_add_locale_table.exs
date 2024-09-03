defmodule UserDatabase.Repo.Migrations.AddLocaleTable do
  use Ecto.Migration

  def change do
    create table(:locales) do
      add :country, :string, null: false
      add :post_code, :string, null: false
      timestamps()
    end
  end
end
