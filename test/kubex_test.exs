defmodule KubexTest do
  use ExUnit.Case
  doctest Kubex

  test "greets the world" do
    assert Kubex.hello() == :world
  end
end
