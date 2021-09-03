defmodule Kubex.Service do

  alias Kubex.Table
  alias Kubex.Pod

  @moduledoc """
    Service definition and service utilities
  """

  defmodule Service do
    defstruct name: "", cpu: "", memory: ""
  end

  @doc """
    Sort [%Service{}] per field (cpu and memory for now)
  """
  @spec sort_services([%Service{}], map()) :: [%Service{}]
  def sort_services(svcs, opts) do
    case opts do
        [sort_by: "cpu"] -> Enum.sort_by(svcs, &(&1.cpu))
        [sort_by: "memory"] -> Enum.sort_by(svcs, &(&1.memory))
    end
  end

  @doc """
    Serialize cmd output into list of Service structs
  """
  @spec serialize_services(list) :: list
  def serialize_services(services) do
    services
    |> acc_service_metrics
    |> Enum.map(&serialize_service/1)
  end

  @doc """
    Initialize a Service struct given name, cpu and memory
  """
  @spec serialize_service(list()) :: %Service{}
  def serialize_service([name, cpu, memory]) do
    %Service{
        name: name,
        cpu: cpu,
        memory: memory,
    }
  end

  @doc """
    Print services in shell format
  """
  @spec format_services([%Service{}]) :: [%Service{}]
  def format_services(services) do
    [["SERVICE", "CPU", "MEMORY"] | services]
    |> Enum.map(&print_service/1)
    |> Table.format(padding: 2)
    |> IO.puts
  end

  @spec print_service(map()) :: list()
  def print_service({service, {cpu, ram}}) do
    [service, cpu, ram]
  end

  @spec print_service(list) :: list()
  def print_service([name, cpu, memory]) do
    [name, cpu, memory]
  end

  @spec print_service(%Service{}) :: list()
  def print_service(svc) do
    ["#{svc.name}", "#{svc.cpu}", "#{svc.memory}"]
  end

  @spec acc_service_metrics([%Pod.Pod{}]) :: map()
  def acc_service_metrics(pods) do
    pods
    |> Enum.map(&Pod.print_pod/1)
    |> Enum.reduce(%{}, fn [_, key, _, stat0, stat1], accumulator ->
      int0 = String.to_integer(stat0)
      int1 = String.to_integer(stat1)
      Map.update(accumulator, key, {int0, int1}, fn {x, y} -> {x + int0, y + int1} end)
    end)
    |> Enum.map(&print_service/1)
  end


end
