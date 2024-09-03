defmodule UserDatabase.Repo.Migrations.ModifyProfileDobColumnNaive do
  use Ecto.Migration

  def change do
    alter table(:profiles) do
      modify :dob, :naive_datetime
    end
  end
end
