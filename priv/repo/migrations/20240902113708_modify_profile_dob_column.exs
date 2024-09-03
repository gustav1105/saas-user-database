defmodule UserDatabase.Repo.Migrations.ModifyProfileDobColumn do
  use Ecto.Migration

  def change do
    alter table(:profiles) do
      modify :dob, :utc_datetime
    end
  end
end
