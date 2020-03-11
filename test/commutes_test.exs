defmodule CommutesTest do
  use ExUnit.Case
  doctest Commutes

  test "greets the world" do
    assert Commutes.hello() == :world
  end
end
