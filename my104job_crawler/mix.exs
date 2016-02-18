defmodule My104jobCrawler.Mixfile do
  use Mix.Project

  def project do
    [app: :my104job_crawler,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [ mod: {My104jobCrawler, []}, 
      applications: [:postgrex, :ecto, :logger, :httpotion, :tzdata, :logger]]
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
  defp deps do
    [
      {:json,   "~> 0.3.0"},
      {:ibrowse, github: "cmullaparthi/ibrowse"},
      {:httpotion, "~> 2.1.0"},
      {:timex, github: "bitwalker/timex"},
      {:postgrex, ">= 0.0.0"},
      {:ecto, "~> 1.0"}
    ]
  end

end

defmodule Mix.Tasks.My_task do
  use Mix.Task

  @shortdoc "Perform my task"

  def run(_) do
    IO.puts "Working"
  end
end
