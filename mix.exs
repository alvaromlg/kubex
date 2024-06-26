defmodule Kubex.MixProject do
  use Mix.Project

  def project do
    [
      app: :kubex,
      version: "0.1.1",
      elixir: "~> 1.16.1",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: Kubex.CLI],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:k8s, "~> 2.0"},
      {:json, "~> 1.4.1"},
      {:poison, "~> 5.0"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
