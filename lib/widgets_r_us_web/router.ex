defmodule WidgetsRUsWeb.Router do
  use WidgetsRUsWeb, :router

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

  scope "/", WidgetsRUsWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: WidgetsRUsWeb.Schema, interface: :simple

    forward "/", Absinthe.Plug, schema: WidgetsRUsWeb.Schema, interface: :simple
  end
end
