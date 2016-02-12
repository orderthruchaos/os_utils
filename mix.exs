defmodule OSUtils.Mixfile do
  use Mix.Project

  @version "0.3.0"
  @github  "https://github.com/orderthruchaos/os_utils"

  def project do
    [
      app: :os_utils,
      version: @version,
      elixir: ">= 1.2.0",
      deps: deps,
      description: "OS utilities for Elixir.",
      package: [
        contributors: ["Brett DiFrischia"],
        licenses: ["Apache 2.0"],
        links: %{ "Github" => @github },
      ],
      docs: [
        readme: true,
        main: "README",
        source_url: @github,
        source_ref: @version,
      ],
    ]
  end

  def application, do: []

  defp deps do
    [
      {:ex_doc, "~> 0.5", only: :dev}
    ]
  end
end
