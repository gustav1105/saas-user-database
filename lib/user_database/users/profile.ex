defmodule UserDatabase.Users.Profile do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  schema "profiles" do
    field :first_name, :string
    field :last_name, :string
    field :dob, :naive_datetime
    timestamps()
  end

  @required_params [:first_name, :last_name, :dob]

  def changeset(struct = %UserDatabase.Users.Profile{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_dob()
    |> validate_length(:first_name, min: 2, max: 22)
    |> validate_length(:last_name, min: 2, max: 22)
  end

  def by_name(query, search_term) do
    from p in query,
      where: ilike(p.first_name, ^"%#{search_term}%") or
             ilike(p.last_name, ^"%#{search_term}%"),
    select: p
  end

  def by_year(query, year) do
    from p in query,
      where: fragment("EXTRACT(YEAR FROM ?)", p.dob) == ^year,
    select: p
  end

  def by_age_range(query, start_age, end_age) do
    current_year = Date.utc_today().year
    start_year = current_year - start_age
    end_year = current_year - end_age
  
    from p in query,
      where:
        fragment("EXTRACT(YEAR FROM ?)", p.dob) <= ^start_year and
        fragment("EXTRACT(YEAR FROM ?)", p.dob) >= ^end_year,
      select: p
  end
  
  defp validate_dob(changeset) do
    dob = get_field(changeset, :dob)

    if dob && NaiveDateTime.compare(dob, NaiveDateTime.utc_now()) == :gt do
      add_error(changeset, :dob, "Welcome time traveler. you may not enter")
    else
      changeset
    end
  end
end

