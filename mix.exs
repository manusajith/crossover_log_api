defmodule LogApi.Mixfile do
  use Mix.Project

  def project do
    [
      app:             :log_api,
      version:         "0.0.1",
      elixir:          "~> 1.5",
      elixirc_paths:   elixirc_paths(Mix.env),
      compilers:       [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases:         aliases(),
      deps:            deps(),
    ]
  end

  def application do
    [
      mod: {LogApi.Application, []},
      extra_applications: [
        :logger,
        :runtime_tools,
        :eventstore,
        :hammer,
      ],
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:comeonin,                     "~> 3.1"},
      {:commanded,                    "~> 0.13"},
      {:commanded_ecto_projections,   "~> 0.4"},
      {:commanded_eventstore_adapter, "~> 0.1"},
      {:cors_plug,                    "~> 1.4"},
      {:cowboy,                       "~> 1.0"},
      {:exconstructor,                "~> 1.1"},
      {:ex_machina,                   "~> 2.0", only: :test},
      {:gettext,                      "~> 0.11"},
      {:guardian,                     "~> 0.14"},
      {:mix_test_watch,               "~> 0.4", only: :dev, runtime: false},
      {:phoenix,                      "~> 1.3.0"},
      {:phoenix_ecto,                 "~> 3.2"},
      {:postgrex,                     ">= 0.0.0"},
      {:slugger,                      "~> 0.2"},
      {:uuid,                         "~> 1.1"},
      {:vex,                          "~> 0.6"},
      {:hammer,                       "~> 0.2.1"},
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"],
    ]
  end
end
