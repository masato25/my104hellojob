defmodule Crawler.Controller do
  alias Crawler.DBAction
  alias Crawler.CrawlerAction

  def getnext(pid) do
    d = CrawlerAction.nextpage(pid)
    if d != [] do
      d |> Enum.map(&DBAction.create(&1))
      getnext(pid)
    else
      IO.puts("jobs finished")
    end
  end

  def getdata() do
    {:ok, pid} = CrawlerAction.new
    CrawlerAction.get(pid) |> Enum.map(&DBAction.create(&1))
    getnext(pid)
  end

end
