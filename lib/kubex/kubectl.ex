defmodule Kubex.KubeCTL do

  alias Kubex.Pod
  alias Kubex.Service

  def run_kubectl_cmd(args) do
    System.cmd("kubectl", args)
  end

  def get_pods_info(opts) do
    run_kubectl_cmd(["top", "pod", "--all-namespaces"])
    |> Pod.serialize_pods
    |> Pod.sort_pods(opts)
    |> Pod.format_pods
  end

  def get_svc_info(opts) do
    run_kubectl_cmd(["top", "pod", "--all-namespaces"])
    |> Pod.serialize_pods
    |> Service.serialize_services
    |> Service.sort_services(opts)
    |> Service.format_services
  end

end
