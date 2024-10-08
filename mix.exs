defmodule TaskBunny.Mixfile do
  use Mix.Project

  @version "0.3.2"
  @description "Background processing application/library written in Elixir that uses RabbitMQ as a messaging backend"

  def project do
    [
      app: :task_bunny,
      version: @version,
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "TaskBunny",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      dialyzer: [ignore_warnings: "dialyzer.ignore-warnings"],
      docs: [
        extras: ["README.md"],
        main: "readme",
        source_ref: "v#{@version}",
        source_url: "https://github.com/shinyscorpion/task_bunny"
      ],
      description: @description,
      package: package(),
      xref: [exclude: [Wobserver]]
    ]
  end

  defp package do
    [
      name: :task_bunny,
      files: [
        # Project files
        "mix.exs",
        "README.md",
        "LICENSE.md",
        # TaskBunny
        "lib/task_bunny.ex",
        "lib/task_bunny",
        # Tasks
        "lib/mix/tasks/task_bunny.queue.reset.ex"
      ],
      maintainers: [
        "Elliott Hilaire",
        "Francesco Grammatico",
        "Ian Luites",
        "Ricardo Perez",
        "Tatsuya Ono",
        "Kenneth Lee"
      ],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/shinyscorpion/task_bunny"}
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {TaskBunny, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:amqp, "~> 3.3"},
      {:poison, "~> 5.0"},

      # dev/test
      {:credo, "~> 0.6", only: [:dev]},
      {:dialyxir, "~> 0.4", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.14", only: :dev},
      {:excoveralls, "~> 0.5", only: :test},
      {:logger_file_backend, "~> 0.0.9", only: :test},
      {:meck, "~> 0.8.2", only: :test},
      {:common_tsg, common_tsg()}
    ]
  end

  defp common_tsg do
    env_dep_switch([path: "../common-tsg", override: true],
      git: "git@github.com:tsg-global/common-tsg.git",
      branch: "master"
    )
  end

  defp env_dep_switch(local_path, remote_path) do
    case Mix.env() do
      local when local in [:dev, :test] -> local_path
      _remote -> remote_path
    end
  end
end
