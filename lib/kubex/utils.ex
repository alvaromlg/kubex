defmodule Kubex.Utils do

  @moduledoc """
    Utility functions
  """

  @spec decode_cmd_response({map(), 0}) :: map()
  def decode_cmd_response({json, 0}) do
    Poison.decode!(json, keys: :atoms)
  end

  @spec get_integer(String.t()) :: Integer.t()
  def get_integer(string) do
    string
    |> String.replace(~r/[^\d]/, "")
    |> String.to_integer
  end

end
