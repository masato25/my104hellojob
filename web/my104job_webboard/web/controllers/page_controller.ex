defmodule My104jobWebboard.PageController do
  use My104jobWebboard.Web, :controller
  alias My104jobWebboard.Job
  alias My104jobWebboard.Repo
  def index(conn, _params) do
    render conn, "index.html"
  end

  def listmyjobs(conn, _params) do
    jj = Repo.all(Job)
    render conn, "joblistreact.html", [jj: jj]
  end

  def joblistapi(conn, _params) do
    jj = Repo.all(Job)
    json conn, jj
  end

  def about(conn, _params) do
    render conn, "about.html"
  end
end
