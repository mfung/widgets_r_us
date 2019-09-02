defmodule WidgetsRUsWeb.LineItemController do
  use WidgetsRUsWeb, :controller

  alias WidgetsRUs.Sales
  alias WidgetsRUs.Sales.LineItem

  action_fallback WidgetsRUsWeb.FallbackController

  def index(conn, _params) do
    line_items = Sales.list_line_items()
    render(conn, "index.json", line_items: line_items)
  end

  def create(conn, %{"line_item" => line_item_params}) do
    with {:ok, %LineItem{} = line_item} <- Sales.create_line_item(line_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.line_item_path(conn, :show, line_item))
      |> render("show.json", line_item: line_item)
    end
  end

  def show(conn, %{"id" => id}) do
    line_item = Sales.get_line_item!(id)
    render(conn, "show.json", line_item: line_item)
  end

  def update(conn, %{"id" => id, "line_item" => line_item_params}) do
    line_item = Sales.get_line_item!(id)

    with {:ok, %LineItem{} = line_item} <- Sales.update_line_item(line_item, line_item_params) do
      render(conn, "show.json", line_item: line_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    line_item = Sales.get_line_item!(id)

    with {:ok, %LineItem{}} <- Sales.delete_line_item(line_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
