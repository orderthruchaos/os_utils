defmodule OsUtils.Mixfile do
  use Mix.Project

  @version "0.1.0"
  @github  "https://github.com/orderthruchaos/os_utils"

  def project do
    [
      app: :os_utils,
      version: @version,
      elixir: ">= 0.15.0",
      deps: deps,
      package: [
        contributors: ["Brett DiFrischia"],
        licenses: ["Apache 2.0"],
        links: [
          {"Github", @github}
        ]
      ],
      description: "OS utilities for Elixir."
      # ,
      # docs: [
      #   readme: true,
      #   main: "README",
      #   source_url: @github,
      #   source_ref: @version
      # ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application, do: []

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps, do: []
end
