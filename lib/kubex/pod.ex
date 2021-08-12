defmodule Kubex.Pod do

  alias Kubex.Utils
  alias Kubex.Table

  @moduledoc """
    Pod definition and pod utilities
  """

  defmodule Pod do
    defstruct name: "", namespace: "", cpu: "", memory: "", node: ""
  end

  @doc """
    Serialize cmd output into list of Pod structs
  """
  @spec serialize_pods({[%Pod{}], 0}) :: [%Pod{}]
  def serialize_pods({pods, 0}) do
    {_ , [_ | info]} =
       String.split(pods, "\n")
       |> List.pop_at(-1)
    info
    |> Enum.map(&serialize_pod/1)
  end

  @doc """
    Initialize a Pod struct given namespace, pod, cpu and memory
  """
  @spec serialize_pod(list()) :: %Pod{}
  def serialize_pod(pod) do
    [namespace, pod, cpu, memory, _] =
       String.replace(pod, ~r/ +/, " ")
       |> String.split(" ")
    %Pod{
        namespace: namespace,
        name: pod,
        cpu: Utils.get_integer(cpu),
        memory: Utils.get_integer(memory),
    }
  end

  @doc """
    Print [%Pod{}] nicely on the shell
  """
  @spec print_pods_nicely([%Pod{}]) :: [%Pod{}]
  def print_pods_nicely(pods) do
    pods
    |> Enum.map(&print_pod/1)
    |> Table.format(padding: 2)
    |> IO.puts
  end

  @spec print_pod(%Pod{}) :: String.t
  def print_pod(pod) do
    ["#{pod.name}", "#{pod.namespace}", "#{pod.node}", "#{pod.cpu}", "#{pod.memory}"]
  end

  @doc """
    Sort [%Pod{}] per field (cpu and memory for now)
  """
  @spec sort_pods([%Pod{}], map()) :: [%Pod{}]
  def sort_pods(pods, opts) do
    case opts do
        [sort_by: "cpu"] -> Enum.sort_by(pods, &(&1.cpu))
        [sort_by: "memory"] -> Enum.sort_by(pods, &(&1.memory))
    end
  end

end
