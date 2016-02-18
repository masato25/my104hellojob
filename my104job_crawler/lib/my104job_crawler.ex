defmodule My104jobCrawler do
  use Application
  
  def start(_type, _args) do
    import Supervisor.Spec
    tree = [supervisor(My104jobCrawler.Repo, [])]
    opts = [name: My104jobCrawler.Sup, strategy: :one_for_one]
    Supervisor.start_link(tree, opts)
  end
end
