defmodule UserDatabase.Users do
  use Ecto.Schema
  import Ecto.Query

  alias UserDatabase.{Repo, Users.Profile, Users.User}

  def all(params) do
    params
    |> Enum.reduce(User, &convert_field_to_query/2)
    |> Repo.all()
    |> Repo.preload([:profile, :locale])
  end

  def by_name(search_term) do
    search_pattern = "%#{search_term}%"

    User
    |> join(:inner, [u], p in assoc(u, :profile))
    |> join(:inner, [u, p], l in assoc(p, :locale))
    |> where([_, p, _], ilike(p.first_name, ^search_pattern) or ilike(p.last_name, ^search_pattern))
    |> preload([:profile, :locale])
    |> Repo.all()
  end

  defp convert_field_to_query({:between_age, {start_age, end_age}}, query) do
    Profile.by_age_range(query, start_age, end_age)
  end

  defp convert_field_to_query({:by_name, value}, query) do
    Profile.by_name(query, value)
  end

  defp convert_field_to_query({:by_year, value}, query) do
    Profile.by_year(query, value)
  end
  
  defp convert_field_to_query({:by_country, {country, post_code}}, query) do
    Profile.by_locale(query, country, post_code)
  end
end

