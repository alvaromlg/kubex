defmodule Kubex.CLI do
  def main(args) do
    args
    |> OptionParser.parse(switches: [file: :string],aliases: [f: :file])
    |> Kubex.CMD.run_command
  end
end
