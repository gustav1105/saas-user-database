defmodule UserDatabase.Repo.Migrations.AddProfileTable do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :first_name, :text, null: false
      add :last_name, :text, null: false
      add :dob, :date
      timestamps()
    end
  end
end
