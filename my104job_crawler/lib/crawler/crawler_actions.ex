defmodule Crawler.CrawlerAction do
  use GenServer

  def new(url \\ "http://www.104.com.tw/i/apis/jobsearch.cfm?cat=2007001000&sltp=S&slmin=50000&slmax=150000&fmt=8&page=1&pgsz=25" ) do
    GenServer.start_link(__MODULE__, url)
  end

  def init(url) do
    {:ok, getcontext(url)}
  end

  def getcontext(url) do
    resp = HTTPotion.get(url)
    jsdata = JSON.decode!(resp.body)
    totallpage = String.to_integer(jsdata["TOTALPAGE"])
    currentpage = String.to_integer(jsdata["PAGE"])
    data = jsdata["data"]
    %{:data => data, :totallpage => totallpage, :currentpage => currentpage}
  end

  def next(currentpage, totallpage) do
    if(currentpage <= totallpage) do
      getcontext("http://www.104.com.tw/i/apis/jobsearch.cfm?cat=2007001000&sltp=S&slmin=50000&slmax=150000&fmt=8&page=#{currentpage}&pgsz=25")
    else
      %{:data => [], :totallpage => totallpage, :currentpage => currentpage}
    end
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  def nextpage(pid) do
    GenServer.call(pid, :nextpage)
  end

  def setpage(pid, pagenum) do
    GenServer.call(pid, {:setpage, pagenum})
  end

  def handle_call(:get, _from, n) do
    {:reply, n.data, n}
  end

  def handle_call(:nextpage, _from, n) do
    {:reply, n.data, next(n.currentpage + 1, n.totallpage)}
  end

  def handle_call({:setpage, pagenum }, _from, n) do
    {:reply, n.data, next(pagenum, n.totallpage)}
  end

end
