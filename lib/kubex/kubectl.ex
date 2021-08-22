defmodule Kubex.KubeCTL do

  alias Kubex.Utils
  alias Kubex.Pod

  def run_kubectl_cmd(args) do
    System.cmd("kubectl", args)
  end

  def get_pods_info(opts) do
    run_kubectl_cmd(["top", "pod", "--all-namespaces"])
    |> Pod.serialize_pods
    |> Pod.sort_pods(opts)
    |> Enum.map(&add_node_to_pod/1)
    |> Pod.add_field_names
    |> Pod.print_pods_nicely
  end

  @spec add_node_to_pod([%Pod.Pod{}]) :: [%Pod.Pod{}]
  def add_node_to_pod(pod) do
    pod_info =
      run_kubectl_cmd(["get", "pod", pod.name, "-n", pod.namespace, "-o", "json"])
      |> Utils.decode_cmd_response
    Map.put(pod, :node, pod_info.spec.nodeName)
  end

end
