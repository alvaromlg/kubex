defmodule Kubex.Pod do

  alias Kubex.Utils
  alias Kubex.Table
  alias Kubex.KubeCTL

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
    |> Enum.map(&add_node_to_pod/1)
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

  @spec print_pod(String.t) :: String.t
  def print_pod(pod) when is_binary(pod), do: pod

  @spec print_pod(%Pod{}) :: String.t
  def print_pod(pod) when is_map(pod) do
    ["#{pod.name}", "#{pod.namespace}", "#{pod.node}", "#{pod.cpu}", "#{pod.memory}"]
  end

  @spec print_pod(list) :: list
  def print_pod(pod) when is_list(pod), do: pod

  @doc """
    Print [%Pod{}] nicely on the shell
  """
  @spec format_pods([%Pod{}]) :: [String.t]
  def format_pods(pods) do
    [["POD", "WORKLOAD", "NODE", "CPU", "MEMORY"] | pods]
    |> Enum.map(&print_pod/1)
    |> Table.format(padding: 2)
    |> IO.puts
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

  @spec add_node_to_pod([%Pod{}]) :: [%Pod{}]
  def add_node_to_pod(pod) do
    pod_info =
      KubeCTL.run_kubectl_cmd(["get", "pod", pod.name, "-n", pod.namespace, "-o", "json"])
      |> Utils.decode_cmd_response
    Map.put(pod, :node, pod_info.spec.nodeName)
  end


end
