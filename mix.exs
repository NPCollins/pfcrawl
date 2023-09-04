defmodule Pfcrawl.MixProject do
  use Mix.Project

  def project do
    [
      app: :pfcrawl,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Pfcrawl.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:crawly, "~> 0.16.0"},
      {:floki, "~> 0.33.0"},
      {:req, "~> 0.4.0"}
    ]
  end
end
