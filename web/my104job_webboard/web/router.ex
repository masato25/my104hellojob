defmodule My104jobWebboard.Router do
  use My104jobWebboard.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", My104jobWebboard do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :listmyjobs
    get "/joblistapi", PageController, :joblistapi
    get "/about", PageController, :about
  end

  # Other scopes may use custom stacks.
  # scope "/api", My104jobWebboard do
  #   pipe_through :api
  # end
end
