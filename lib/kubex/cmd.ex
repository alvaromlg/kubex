defmodule Kubex.CMD do

  @moduledoc """
    Different module from CLI because its purpose is to
    differentiate if its a k8s, kubectl or kube api command
  """

  @doc """
    Command parser
  """
  @spec run_command(map()) :: String.t()
  def run_command({opts, [cmd], _}) do
    case cmd do
      "help" -> IO.inspect "help"
      "pods" -> Kubex.KubeCTL.get_pods_info(opts)
      "services" -> Kubex.KubeCTL.get_svc_info(opts)
    end
  end

end
