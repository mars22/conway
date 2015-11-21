defmodule Conway.Mixfile do
  use Mix.Project

  def project do
    [app: :conway,
     mod: {Conway.CLI,[]},
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: escript_config,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      { :benchwarmer, "~> 0.0.2" },
      {:credo, "~> 0.1.9", only: [:dev, :test]}
    ]
  end

  defp escript_config do
    [main_module: Conway.CLI]
  end

end
