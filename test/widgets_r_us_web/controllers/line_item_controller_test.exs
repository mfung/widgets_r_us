defmodule WidgetsRUsWeb.LineItemControllerTest do
  use WidgetsRUsWeb.ConnCase

  alias WidgetsRUs.Sales
  alias WidgetsRUs.Sales.LineItem

  @create_attrs %{
    quantity: 42,
    total: 120.5
  }
  @update_attrs %{
    quantity: 43,
    total: 456.7
  }
  @invalid_attrs %{quantity: nil, total: nil}

  def fixture(:line_item) do
    {:ok, line_item} = Sales.create_line_item(@create_attrs)
    line_item
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all line_items", %{conn: conn} do
      conn = get(conn, Routes.line_item_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create line_item" do
    test "renders line_item when data is valid", %{conn: conn} do
      conn = post(conn, Routes.line_item_path(conn, :create), line_item: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.line_item_path(conn, :show, id))

      assert %{
               "id" => id,
               "quantity" => 42,
               "total" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.line_item_path(conn, :create), line_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update line_item" do
    setup [:create_line_item]

    test "renders line_item when data is valid", %{conn: conn, line_item: %LineItem{id: id} = line_item} do
      conn = put(conn, Routes.line_item_path(conn, :update, line_item), line_item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.line_item_path(conn, :show, id))

      assert %{
               "id" => id,
               "quantity" => 43,
               "total" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, line_item: line_item} do
      conn = put(conn, Routes.line_item_path(conn, :update, line_item), line_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete line_item" do
    setup [:create_line_item]

    test "deletes chosen line_item", %{conn: conn, line_item: line_item} do
      conn = delete(conn, Routes.line_item_path(conn, :delete, line_item))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.line_item_path(conn, :show, line_item))
      end
    end
  end

  defp create_line_item(_) do
    line_item = fixture(:line_item)
    {:ok, line_item: line_item}
  end
end
