defmodule WidgetsRUsWeb.PageController do
  use WidgetsRUsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
