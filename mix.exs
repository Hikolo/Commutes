defmodule Commutes.MixProject do
  use Mix.Project

  def project do
    [
      app: :commutes,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      
      # Docs
      name: "Commutes",
      source_url: "http://github.com/Hikolo/Commutes",
      docs: [main: "Commutes", # Main page
      extras: ["README.md"]]]
      end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Commutes.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:httpoison, "~> 1.6"},
      {:poison, "~> 4.0.1"}
    ]
  end
end
