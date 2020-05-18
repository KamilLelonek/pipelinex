defmodule Pipelinex.MixProject do
  use Mix.Project

  def project do
    [
      app: :pipelinex,
      version: "0.1.0",
      elixir: "~> 1.9",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      package: package(),
      source_url: "https://github.com/KamilLelonek/pipelinex",
      homepage_url: "https://blog.lelonek.me/how-to-keep-piping-in-elixir-cc3552359238"
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Pipelinex.Application, []}
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    """
  end

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/KamilLelonek/pipelinex"}
    ]
  end
end
