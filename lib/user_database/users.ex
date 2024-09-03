defmodule UserDatabase.Users do
  alias UserDatabase.{Repo, Users.Profile}

  def all(params) do
    params
    |> Enum.reduce(Profile, &convert_field_to_query/2)
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

