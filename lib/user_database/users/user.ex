defmodule UserDatabase.Users.User do
  use Ecto.Schema
  
  import Ecto.Changeset
  import Ecto.Query

  alias UserDatabase.{Repo, Users.Profile, Users.Locale}

  schema "users" do
    belongs_to :profile, Profile
    belongs_to :locale, Locale
    timestamps()
  end

  @required_params [:profile_id, :locale_id]

  def changeset(struct = %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint(:profile_id, name: :users_profile_id_locale_id_index)
    |> unique_constraint(:locale_id, name: :users_profile_id_locale_id_index)
  end
end

