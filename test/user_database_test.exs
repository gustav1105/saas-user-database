defmodule UserDatabaseTest do
  use ExUnit.Case
  doctest UserDatabase

  test "greets the world" do
    assert UserDatabase.hello() == :world
  end
end
