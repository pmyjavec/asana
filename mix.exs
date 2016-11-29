defmodule Asana.Mixfile do
  use Mix.Project

  def project do
    [app: :asana,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      mod: {Asana, []},
      applications: [:logger, :cowboy, :plug, :postgrex, :ecto]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  def deps do
    [{:cowboy, "~> 1.0.0"},
     {:plug, "~> 1.0"},
     {:poison, "~> 2.0"},
     {:ecto, "~> 2.0"},
     {:postgrex, ">= 0.0.0"}
   ]
  end
end
